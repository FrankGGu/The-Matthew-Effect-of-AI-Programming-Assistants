#include <stdlib.h> // For malloc, free
#include <string.h> // For memset (optional, but good for hash table initialization)

struct ListNode {
    int val;
    struct ListNode *next;
};

typedef struct HashEntry {
    int sum;
    struct ListNode* node;
    struct HashEntry* next; // For chaining
} HashEntry;

#define HASH_TABLE_SIZE 2003 

HashEntry* hashTable[HASH_TABLE_SIZE];

int getHash(int sum) {
    // Map sum to a non-negative index.
    // Sums can range from -1000*1000 to 1000*1000, i.e., [-1,000,000, 1,000,000].
    // Shift by 1,000,000 to get a positive range [0, 2,000,000] before modulo.
    return (sum + 1000000) % HASH_TABLE_SIZE;
}

HashEntry* createEntry(int sum, struct ListNode* node) {
    HashEntry* newEntry = (HashEntry*)malloc(sizeof(HashEntry));
    newEntry->sum = sum;
    newEntry->node = node;
    newEntry->next = NULL;
    return newEntry;
}

void insert(int sum, struct ListNode* node) {
    int hashIndex = getHash(sum);
    HashEntry* current = hashTable[hashIndex];

    // Check if sum already exists, if so, update its node
    while (current != NULL) {
        if (current->sum == sum) {
            current->node = node; // Update the node
            return;
        }
        current = current->next;
    }

    // If not found, create a new entry and add to head of chain
    HashEntry* newEntry = createEntry(sum, node);
    newEntry->next = hashTable[hashIndex];
    hashTable[hashIndex] = newEntry;
}

struct ListNode* find(int sum) {
    int hashIndex = getHash(sum);
    HashEntry* current = hashTable[hashIndex];
    while (current != NULL) {
        if (current->sum == sum) {
            return current->node;
        }
        current = current->next;
    }
    return NULL;
}

void removeEntry(int sum) {
    int hashIndex = getHash(sum);
    HashEntry* current = hashTable[hashIndex];
    HashEntry* prev = NULL;

    while (current != NULL) {
        if (current->sum == sum) {
            if (prev == NULL) { // Head of the chain
                hashTable[hashIndex] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current); // Free the removed entry
            return;
        }
        prev = current;
        current = current->next;
    }
}

void clearHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        HashEntry* current = hashTable[i];
        while (current != NULL) {
            HashEntry* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

struct ListNode* removeZeroSumSublists(struct ListNode* head) {
    // Clear hash table for a new test case run
    clearHashTable();

    // Create a dummy node to handle cases where the head itself needs to be removed
    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->val = 0;
    dummy->next = head;

    long long current_prefix_sum = 0; // Use long long to prevent overflow for intermediate sums
    struct ListNode* iter = dummy; // `iter` is the current node being processed

    // The map stores (cumulative_sum, node_pointer) where node_pointer is the node *at* which the sum was achieved.
    // Initialize with (0, dummy) because the sum is 0 before starting to traverse the actual list.
    insert(0, dummy);

    while (iter != NULL) {
        current_prefix_sum += iter->val; // Update cumulative sum up to `iter` (inclusive)

        struct ListNode* prev_node_with_same_sum = find(current_prefix_sum);

        if (prev_node_with_same_sum != NULL) {
            // A zero-sum sublist has been found.
            // `prev_node_with_same_sum` is the node where `current_prefix_sum` was last seen.
            // `iter` is the current node where `current_prefix_sum` is seen again.
            // The segment from `prev_node_with_same_sum->next` up to `iter` sums to zero.

            // Remove intermediate sums from the hash table.
            // These are sums corresponding to nodes within the zero-sum segment.
            struct ListNode* node_to_remove_from_map = prev_node_with_same_sum->next;
            // `temp_sum_for_cleanup` starts as the sum *at* `prev_node_with_same_sum`.
            long long temp_sum_for_cleanup = current_prefix_sum - iter->val; 

            while (node_to_remove_from_map != iter) {
                temp_sum_for_cleanup += node_to_remove_from_map->val;
                removeEntry(temp_sum_for_cleanup); // Remove the intermediate sum from map
                node_to_remove_from_map = node_to_remove_from_map->next;
            }

            // Link `prev_node_with_same_sum` to skip the zero-sum segment.
            prev_node_with_same_sum->next = iter->next;

            // Reset `iter` to `prev_node_with_same_sum`.
            // The outer loop's `iter = iter->next` will then correctly move it to the node
            // that `prev_node_with_same_sum` now points to, effectively continuing traversal
            // from after the removed segment.
            iter = prev_node_with_same_sum;

            // `current_prefix_sum` remains unchanged because the sum of the removed segment is zero.
            // So, sum up to `prev_node_with_same_sum` is still `current_prefix_sum`.
        } else {
            // Sum not found, add `current_prefix_sum` and `iter` node to map.
            insert(current_prefix_sum, iter);
        }

        iter = iter->next; // Move to the next node in the (potentially modified) list
    }

    struct ListNode* result = dummy->next;
    free(dummy); // Free the dummy node
    return result;
}