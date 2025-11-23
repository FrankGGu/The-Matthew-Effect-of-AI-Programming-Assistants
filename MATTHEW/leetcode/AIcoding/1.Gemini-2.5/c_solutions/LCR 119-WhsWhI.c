#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct Node {
    int val;
    struct Node* next;
} Node;

#define HASH_TABLE_SIZE 200003 

Node* hashTable[HASH_TABLE_SIZE];

unsigned int getHashIndex(int val) {
    return (unsigned int)(val + 2000000000) % HASH_TABLE_SIZE;
}

void hashSetAdd(int val) {
    unsigned int index = getHashIndex(val);
    Node* current = hashTable[index];
    while (current != NULL) {
        if (current->val == val) {
            return; // Value already exists
        }
        current = current->next;
    }
    // Value not found, add it to the beginning of the list in the bucket
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

bool hashSetContains(int val) {
    unsigned int index = getHashIndex(val);
    Node* current = hashTable[index];
    while (current != NULL) {
        if (current->val == val) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void hashSetFree() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        Node* current = hashTable[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL; // Clear the bucket head pointer
    }
}

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    // Initialize hash table by setting all bucket pointers to NULL.
    // This is crucial for each test case run on LeetCode.
    memset(hashTable, 0, sizeof(hashTable));

    // Add all numbers from the input array to the hash set.
    // This allows for O(1) average time lookups.
    for (int i = 0; i < numsSize; ++i) {
        hashSetAdd(nums[i]);
    }

    int maxLength = 0;

    // Iterate through the numbers again to find the longest consecutive sequence.
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];

        // Optimization: Only try to build a sequence if 'num - 1' is not in the set.
        // This ensures we only start counting from the true beginning of a sequence,
        // preventing redundant checks and ensuring overall O(N) average time complexity.
        if (!hashSetContains(num - 1)) {
            int currentNum = num;
            int currentLength = 1;

            // Extend the sequence upwards as long as consecutive numbers exist in the set.
            while (hashSetContains(currentNum + 1)) {
                currentNum++;
                currentLength++;
            }

            // Update the maximum length found so far.
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }
    }

    // Free all dynamically allocated memory used by the hash table.
    hashSetFree();

    return maxLength;
}