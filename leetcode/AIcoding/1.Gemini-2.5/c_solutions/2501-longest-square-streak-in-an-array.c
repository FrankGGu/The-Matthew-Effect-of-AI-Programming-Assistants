#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

#define HASH_TABLE_SIZE 200003 // A prime number roughly 2*10^5

typedef struct {
    int key;
    int value;
    bool occupied;
} HashEntry;

HashEntry* hashTable;

void initHashTable() {
    hashTable = (HashEntry*)calloc(HASH_TABLE_SIZE, sizeof(HashEntry));
}

void freeHashTable() {
    free(hashTable);
}

unsigned int hash(int key) {
    return (unsigned int)key % HASH_TABLE_SIZE;
}

void hashPut(int key, int value) {
    unsigned int index = hash(key);
    while (hashTable[index].occupied && hashTable[index].key != key) {
        index = (index + 1) % HASH_TABLE_SIZE;
    }
    hashTable[index].key = key;
    hashTable[index].value = value;
    hashTable[index].occupied = true;
}

int hashGet(int key) {
    unsigned int index = hash(key);
    while (hashTable[index].occupied) {
        if (hashTable[index].key == key) {
            return hashTable[index].value;
        }
        index = (index + 1) % HASH_TABLE_SIZE;
    }
    return -1; // Not found
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int longestSquareStreak(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    initHashTable();

    int max_streak = -1;

    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        long long prev_ll = (long long)sqrt(num);

        int current_streak_len = 1;

        if (prev_ll * prev_ll == num) {
            int prev_num = (int)prev_ll;
            int prev_streak = hashGet(prev_num);
            if (prev_streak != -1) {
                current_streak_len = prev_streak + 1;
            }
        }

        hashPut(num, current_streak_len);

        if (current_streak_len >= 2) {
            if (current_streak_len > max_streak) {
                max_streak = current_streak_len;
            }
        }
    }

    freeHashTable();

    return max_streak;
}