#include <stdlib.h> // For malloc, calloc, free

typedef struct HashNode {
    int key;
    int val; // frequency
    struct HashNode *next;
} HashNode;

typedef struct {
    HashNode **table;
    int size;
} HashMap;

unsigned int hash(int key, int table_size) {
    return (unsigned int)(((long long)key % table_size + table_size) % table_size);
}

HashMap* createHashMap(int table_size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    if (!map) return NULL; // Handle allocation failure
    map->size = table_size;
    // Allocate memory for the table array and initialize all pointers to NULL
    map->table = (HashNode**)calloc(table_size, sizeof(HashNode*));
    if (!map->table) {
        free(map);
        return NULL; // Handle allocation failure
    }
    return map;
}

void hashMapPut(HashMap* map, int key, int val) {
    unsigned int index = hash(key, map->size);
    HashNode* node = map->table[index];

    // Traverse the linked list at the hash index to find if the key already exists
    while (node != NULL) {
        if (node->key == key) {
            node->val = val; // Key found, update its value
            return;
        }
        node = node->next;
    }

    // Key not found, create a new node and prepend it to the list
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    if (!newNode) return; // Handle allocation failure
    newNode->key = key;
    newNode->val = val;
    newNode->next = map->table[index]; // Link new node to the head of the list
    map->table[index] = newNode;       // Update head of the list to new node
}

int hashMapGet(HashMap* map, int key) {
    unsigned int index = hash(key, map->size);
    HashNode* node = map->table[index];

    // Traverse the linked list at the hash index
    while (node != NULL) {
        if (node->key == key) {
            return node->val; // Key found, return its value
        }
        node = node->next;
    }
    return 0; // Key not found, return 0 (default frequency)
}

void freeHashMap(HashMap* map) {
    if (!map) return;
    for (int i = 0; i < map->size; i++) {
        HashNode* node = map->table[i];
        while (node != NULL) {
            HashNode* temp = node;
            node = node->next;
            free(temp); // Free each node in the linked list
        }
    }
    free(map->table); // Free the array of hash node pointers
    free(map);        // Free the HashMap structure itself
}

int subarraySum(int* nums, int numsSize, int k) {
    // Choose a prime number for the hash table size.
    // A size roughly 2x the maximum number of distinct keys (numsSize + 1)
    // is often a good heuristic to minimize collisions.
    // For numsSize up to 2 * 10^4, 20003 is a good prime choice.
    int TABLE_SIZE = 20003; 

    HashMap* map = createHashMap(TABLE_SIZE);
    if (!map) return 0; // Handle hash map creation failure

    // Initialize the hash map with a prefix sum of 0 having a frequency of 1.
    // This handles cases where a subarray starting from index 0 sums to k.
    // If current_sum equals k, then current_sum - k = 0, and we need to count
    // the initial 0 prefix sum.
    hashMapPut(map, 0, 1);

    int count = 0;         // Total number of subarrays that sum to k
    int current_sum = 0;   // The running sum of elements from the beginning of the array

    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i]; // Update the running sum

        // We are looking for a previous prefix sum (let's call it 'prev_sum')
        // such that current_sum - prev_sum = k.
        // This means prev_sum = current_sum - k.
        int target_previous_sum = current_sum - k;

        // If 'target_previous_sum' exists in our hash map, it means there are
        // 'N' subarrays ending at the current index whose sum is k, where 'N'
        // is the frequency of 'target_previous_sum' in the map.
        count += hashMapGet(map, target_previous_sum);

        // Increment the frequency of the 'current_sum' in the hash map
        // for future calculations.
        int current_sum_freq = hashMapGet(map, current_sum);
        hashMapPut(map, current_sum, current_sum_freq + 1);
    }

    freeHashMap(map); // Clean up all allocated memory for the hash map

    return count;
}