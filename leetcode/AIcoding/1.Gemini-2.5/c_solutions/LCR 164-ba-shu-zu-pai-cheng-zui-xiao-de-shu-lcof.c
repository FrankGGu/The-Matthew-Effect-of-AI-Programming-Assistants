#include <stdlib.h> // For malloc, free
#include <string.h> // For memset (though not strictly needed if calloc is used)

typedef struct HashNode {
    long long key;
    int value;
    struct HashNode *next;
} HashNode;

typedef struct HashMap {
    HashNode **buckets;
    int size;
} HashMap;

unsigned int hash(long long key, int size) {
    // A simple hash function using modulo.
    // For better distribution with 64-bit keys, one might use
    // return (unsigned int)((key ^ (key >> 32)) % size);
    // but key % size is often sufficient for common cases.
    return (unsigned int)(key % size);
}

HashMap* createHashMap(int size) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    // calloc initializes memory to zero, so all bucket pointers are NULL
    map->buckets = (HashNode**)calloc(size, sizeof(HashNode*)); 
    return map;
}

void hashMapPut(HashMap *map, long long key) {
    unsigned int bucketIndex = hash(key, map->size);
    HashNode *node = map->buckets[bucketIndex];

    // Traverse the linked list at this bucket
    while (node != NULL) {
        if (node->key == key) {
            node->value++; // Key found, increment count
            return;
        }
        node = node->next;
    }

    // Key not found, create a new node and add it to the beginning of the list
    HashNode *newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->value = 1; // First occurrence
    newNode->next = map->buckets[bucketIndex];
    map->buckets[bucketIndex] = newNode;
}

void freeHashMap(HashMap *map) {
    if (map == NULL) return;

    for (int i = 0; i < map->size; i++) {
        HashNode *node = map->buckets[i];
        while (node != NULL) {
            HashNode *temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

int tupleSameProduct(int* nums, int numsSize) {
    int totalTuples = 0;

    // The maximum number of distinct pairs is numsSize * (numsSize - 1) / 2.
    // For numsSize = 1000, this is ~500,000 pairs.
    // Choose a prime number for hash table size that is roughly similar to or larger
    // than the expected number of distinct keys to maintain a good load factor.
    // 500003 is a prime number.
    HashMap *productCounts = createHashMap(500003); 

    // Iterate through all unique pairs (i, j) where i < j
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            long long product = (long long)nums[i] * nums[j];
            hashMapPut(productCounts, product);
        }
    }

    // Iterate through the hash map to calculate the total number of tuples
    for (int i = 0; i < productCounts->size; i++) {
        HashNode *node = productCounts->buckets[i];
        while (node != NULL) {
            int count = node->value;
            if (count >= 2) {
                // If 'count' pairs result in the same product, we need to choose 2 distinct pairs
                // from these 'count' pairs. The number of ways to do this is C(count, 2) = count * (count - 1) / 2.
                // Each such choice of two pairs (e.g., (a,b) and (c,d) where a*b = c*d)
                // can form 8 distinct tuples:
                // (a,b,c,d), (a,b,d,c), (b,a,c,d), (b,a,d,c),
                // (c,d,a,b), (c,d,b,a), (d,c,a,b), (d,c,b,a)
                totalTuples += (count * (count - 1) / 2) * 8;
            }
            node = node->next;
        }
    }

    // Free the allocated hash map memory
    freeHashMap(productCounts);

    return totalTuples;
}