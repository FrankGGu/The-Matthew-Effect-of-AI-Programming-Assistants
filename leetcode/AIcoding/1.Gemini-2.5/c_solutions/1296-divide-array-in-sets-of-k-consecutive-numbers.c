#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

#define MAX_TABLE_SIZE 200003

typedef struct {
    int key;
    int count;
    bool occupied; // True if this slot is occupied
} HashEntry;

HashEntry hashTable[MAX_TABLE_SIZE]; 

void hash_init() {
    // Using memset to zero-initialize the entire hash table is efficient.
    // This sets occupied to false, key and count to 0 for all entries.
    memset(hashTable, 0, sizeof(hashTable)); 
}

unsigned int hash_func(int key) {
    return (unsigned int)(key % MAX_TABLE_SIZE + MAX_TABLE_SIZE) % MAX_TABLE_SIZE;
}

unsigned int hash_find_slot(int key) {
    unsigned int index = hash_func(key);
    while (hashTable[index].occupied && hashTable[index].key != key) {
        index = (index + 1) % MAX_TABLE_SIZE;
    }
    return index;
}

int hash_get(int key) {
    unsigned int index = hash_find_slot(key);
    if (hashTable[index].occupied && hashTable[index].key == key) {
        return hashTable[index].count;
    }
    return 0; // Key not found or count is 0
}

void hash_put(int key, int count) {
    unsigned int index = hash_find_slot(key);
    hashTable[index].key = key;
    hashTable[index].count = count;
    hashTable[index].occupied = true;
}

bool isPossibleDivide(int* nums, int numsSize, int k) {
    // If the total number of cards is not divisible by k, it's impossible to form sets of k.
    if (numsSize % k != 0) {
        return false;
    }
    // An empty array can be considered as successfully divided into 0 sets.
    if (numsSize == 0) {
        return true;
    }

    // Sort the input array. This ensures we process numbers in increasing order,
    // which is crucial for forming consecutive sets starting from the smallest available number.
    qsort(nums, numsSize, sizeof(int), compareInts);

    // Initialize the hash table for frequency counting
    hash_init();

    // Populate the hash table with frequencies of each number in nums
    for (int i = 0; i < numsSize; i++) {
        hash_put(nums[i], hash_get(nums[i]) + 1);
    }

    // Iterate through the sorted numbers to form sets
    for (int i = 0; i < numsSize; i++) {
        int currentKey = nums[i];
        int currentCount = hash_get(currentKey);

        // If currentKey's count is 0, it means this number has already been
        // used up in previous sets, so we skip it.
        if (currentCount == 0) {
            continue;
        }

        // If currentKey has a positive count, it must be the start of one or more new sets.
        // We need to form 'currentCount' number of sets starting with 'currentKey'.
        int countToDecrement = currentCount;

        // Check and decrement counts for k consecutive numbers starting from currentKey
        for (int l = 0; l < k; l++) {
            int targetKey = currentKey + l;
            int targetCount = hash_get(targetKey);

            // If any of the required consecutive numbers is not available
            // (either not present or its count is less than needed),
            // then it's impossible to form the sets.
            if (targetCount < countToDecrement) {
                return false;
            }
            // Decrement the count for the targetKey
            hash_put(targetKey, targetCount - countToDecrement);
        }
    }

    // If we successfully processed all numbers, it means they can be divided into sets.
    return true;
}