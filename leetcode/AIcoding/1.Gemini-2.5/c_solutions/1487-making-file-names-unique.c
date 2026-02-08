#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define HT_MAX_BUCKETS 50003 // A prime number for hash table capacity

typedef struct HashEntry {
    char *key;
    int value;
} HashEntry;

typedef struct Node {
    HashEntry entry;
    struct Node *next;
} Node;

typedef struct HashTable {
    Node **buckets;
    int capacity;
} HashTable;

unsigned int hash_string(const char *str) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash;
}

HashTable* ht_create(int capacity) {
    HashTable *ht = (HashTable*)malloc(sizeof(HashTable));
    ht->capacity = capacity;
    ht->buckets = (Node**)calloc(capacity, sizeof(Node*)); // Initialize buckets to NULL
    return ht;
}

void ht_insert(HashTable *ht, const char *key, int value) {
    unsigned int index = hash_string(key) % ht->capacity;
    Node *current = ht->buckets[index];

    while (current != NULL) {
        if (strcmp(current->entry.key, key) == 0) {
            current->entry.value = value; // Key found, update value
            return;
        }
        current = current->next;
    }

    // Key not found, create a new node
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->entry.key = strdup(key); // Duplicate key string for storage
    newNode->entry.value = value;
    newNode->next = ht->buckets[index];
    ht->buckets[index] = newNode;
}

int* ht_lookup(HashTable *ht, const char *key) {
    unsigned int index = hash_string(key) % ht->capacity;
    Node *current = ht->buckets[index];

    while (current != NULL) {
        if (strcmp(current->entry.key, key) == 0) {
            return &(current->entry.value);
        }
        current = current->next;
    }
    return NULL; // Not found
}

void ht_free(HashTable *ht) {
    if (!ht) return;
    for (int i = 0; i < ht->capacity; i++) {
        Node *current = ht->buckets[i];
        while (current != NULL) {
            Node *temp = current;
            current = current->next;
            free(temp->entry.key); // Free duplicated key string
            free(temp);
        }
    }
    free(ht->buckets);
    free(ht);
}

char** getFolderNames(char** names, int namesSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = namesSize;
    char** ans = (char**)malloc(namesSize * sizeof(char*));
    *returnColumnSizes = (int*)malloc(namesSize * sizeof(int));

    HashTable *seen_names = ht_create(HT_MAX_BUCKETS); // Stores all names added to 'ans'
    HashTable *name_counts = ht_create(HT_MAX_BUCKETS); // Stores the next 'k' to try for each base name

    // Buffer for constructing names like "name(k)"
    // Max name length 20 + "(k)" (k up to 5 digits for 5*10^4) + null terminator = 20 + 1 + 5 + 1 + 1 = 28.
    // Using 32 for a safe margin.
    char buffer[32]; 

    for (int i = 0; i < namesSize; i++) {
        const char *current_base_name = names[i];

        // Get the next 'k' to try for this base name. Default to 0 if not seen before.
        int *k_ptr = ht_lookup(name_counts, current_base_name);
        int k = (k_ptr != NULL) ? *k_ptr : 0; 

        char *candidate_name_str; // Will point to current_base_name or buffer

        while (1) {
            if (k == 0) {
                candidate_name_str = (char*)current_base_name; // Use original name directly
            } else {
                // Format "base_name(k)" into the buffer
                sprintf(buffer, "%s(%d)", current_base_name, k);
                candidate_name_str = buffer;
            }

            // Check if this candidate name is already in 'seen_names'
            if (ht_lookup(seen_names, candidate_name_str) == NULL) {
                // Name is unique, use it
                ans[i] = strdup(candidate_name_str); // Duplicate string for the result array
                (*returnColumnSizes)[i] = strlen(candidate_name_str);

                ht_insert(seen_names, candidate_name_str, 1); // Mark this name as seen

                // Update name_counts for the base name to the next 'k' (k+1)
                ht_insert(name_counts, current_base_name, k + 1);
                break; // Found a unique name for names[i], move to the next original name
            } else {
                // Name is already seen, increment 'k' and try again
                k++;
                // Update name_counts for the base name to reflect the new 'k' being attempted.
                // This ensures that if "name(k)" was taken by another base name, we don't re-check it.
                ht_insert(name_counts, current_base_name, k);
            }
        }
    }

    ht_free(seen_names);
    ht_free(name_counts);

    return ans;
}