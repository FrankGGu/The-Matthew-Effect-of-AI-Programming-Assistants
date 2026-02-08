#include <stdlib.h>
#include <string.h>

#define HASH_TABLE_MAX_SIZE 200003 // A large prime number for hash table size

typedef struct Entry {
    int cat1;
    int cat2;
    int count;
    struct Entry *next;
} Entry;

Entry **hashTable;
int currentEntries;
int hashTableSize;

static unsigned int hash(int c1, int c2) {
    // Combine two integers into a single hash key.
    // Ensure c1 and c2 are positive for this specific hash.
    // Using a simple polynomial rolling hash.
    unsigned long long key = (unsigned long long)c1 * 31 + c2;
    return key % hashTableSize;
}

static void initHashTable() {
    hashTableSize = HASH_TABLE_MAX_SIZE;
    hashTable = (Entry**)calloc(hashTableSize, sizeof(Entry*));
    currentEntries = 0;
}

static void addPair(int c1, int c2) {
    // Ensure canonical order (c1 < c2) to treat (A,B) and (B,A) as the same pair
    if (c1 > c2) {
        int temp = c1;
        c1 = c2;
        c2 = temp;
    }

    unsigned int idx = hash(c1, c2);
    Entry* current = hashTable[idx];

    // Traverse the linked list at this bucket
    while (current != NULL) {
        if (current->cat1 == c1 && current->cat2 == c2) {
            current->count++;
            return;
        }
        current = current->next;
    }

    // Pair not found, create a new entry
    Entry* newEntry = (Entry*)malloc(sizeof(Entry));
    newEntry->cat1 = c1;
    newEntry->cat2 = c2;
    newEntry->count = 1;
    newEntry->next = hashTable[idx]; // Prepend to the list
    hashTable[idx] = newEntry;
    currentEntries++;
}

static void freeHashTable() {
    for (int i = 0; i < hashTableSize; i++) {
        Entry* current = hashTable[i];
        while (current != NULL) {
            Entry* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(hashTable);
    hashTable = NULL;
}

static int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int** findCategoryRecommendationPairs(int** categories, int categoriesSize, int* categoriesColSize, int* returnSize, int** returnColumnSizes) {
    initHashTable();

    for (int i = 0; i < categoriesSize; i++) {
        int* currentCategories = categories[i];
        int numCategories = categoriesColSize[i];

        // Sort categories for the current item to easily generate canonical pairs
        // and avoid duplicates like (B,A) if (A,B) was already processed.
        // This also helps if the input categories for an item are not sorted.
        if (numCategories > 1) { // Only sort if there's more than one category to form pairs
            qsort(currentCategories, numCategories, sizeof(int), compareInts);
        }

        // Generate all unique pairs for the current item
        for (int j = 0; j < numCategories; j++) {
            for (int k = j + 1; k < numCategories; k++) {
                addPair(currentCategories[j], currentCategories[k]);
            }
        }
    }

    // Collect results from the hash table
    int resultCapacity = currentEntries > 0 ? currentEntries : 10; // Initial guess for capacity
    int** result = (int**)malloc(resultCapacity * sizeof(int*));
    *returnColumnSizes = (int*)malloc(resultCapacity * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < hashTableSize; i++) {
        Entry* current = hashTable[i];
        while (current != NULL) {
            if (*returnSize == resultCapacity) {
                resultCapacity *= 2;
                result = (int**)realloc(result, resultCapacity * sizeof(int*));
                *returnColumnSizes = (int*)realloc(*returnColumnSizes, resultCapacity * sizeof(int));
            }
            result[*returnSize] = (int*)malloc(3 * sizeof(int));
            result[*returnSize][0] = current->cat1;
            result[*returnSize][1] = current->cat2;
            result[*returnSize][2] = current->count;
            (*returnColumnSizes)[*returnSize] = 3;
            (*returnSize)++;
            current = current->next;
        }
    }

    freeHashTable(); // Clean up hash table memory

    return result;
}