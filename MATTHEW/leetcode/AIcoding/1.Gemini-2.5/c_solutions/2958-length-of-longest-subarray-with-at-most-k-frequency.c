#include <stdlib.h> // For malloc, free, calloc

typedef struct HashMapNode {
    int key;
    int value; // Frequency of the key
    struct HashMapNode* next;
} HashMapNode;

typedef struct {
    HashMapNode** buckets; // Array of pointers to HashMapNode (head of chains)
    int size;              // Number of buckets
} HashMap;

static int hash(int key, int size) {
    return (key % size + size) % size; // Ensure positive result
}

static HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    // calloc initializes all allocated memory to zero, so bucket pointers are NULL
    map->buckets = (HashMapNode**)calloc(size, sizeof(HashMapNode*));
    return map;
}

static int get(HashMap* map, int key) {
    int bucketIndex = hash(key, map->size);
    HashMapNode* current = map->buckets[bucketIndex];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return 0; // Key not found, frequency is 0
}

static void put(HashMap* map, int key, int value) {
    int bucketIndex = hash(key, map->size);
    HashMapNode* current = map->buckets[bucketIndex];

    // Check if key already exists, then update its value
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }

    // Key not found, create a new node and add it to the beginning of the chain
    HashMapNode* newNode = (HashMapNode*)malloc(sizeof(HashMapNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[bucketIndex];
    map->buckets[bucketIndex] = newNode;
}

static void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        HashMapNode* current = map->buckets[i];
        while (current != NULL) {
            HashMapNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

int maxSubarrayLength(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    // A prime number for hash map size helps distribute keys better.
    // Max numsSize is 2 * 10^5, so 200003 is a good prime choice for average O(1) operations.
    HashMap* freqMap = createHashMap(200003); 

    int left = 0;
    int max_len = 0;

    for (int right = 0; right < numsSize; right++) {
        // Increment frequency of the current element (nums[right])
        int currentFreq = get(freqMap, nums[right]);
        put(freqMap, nums[right], currentFreq + 1);

        // If the frequency of nums[right] exceeds k, shrink the window from the left
        while (get(freqMap, nums[right]) > k) {
            int leftFreq = get(freqMap, nums[left]);
            put(freqMap, nums[left], leftFreq - 1);
            left++; // Move the left pointer to shrink the window
        }

        // Update the maximum length found so far
        if (right - left + 1 > max_len) {
            max_len = right - left + 1;
        }
    }

    freeHashMap(freqMap); // Free allocated hash map memory
    return max_len;
}