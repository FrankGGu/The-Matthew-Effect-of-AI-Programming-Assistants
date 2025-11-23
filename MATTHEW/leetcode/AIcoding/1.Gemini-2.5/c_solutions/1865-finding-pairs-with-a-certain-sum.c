#include <stdlib.h>
#include <string.h>

typedef struct HashMapNode {
    int key;
    int val;
    struct HashMapNode* next;
} HashMapNode;

HashMapNode* createHashMapNode(int key, int val) {
    HashMapNode* node = (HashMapNode*)malloc(sizeof(HashMapNode));
    node->key = key;
    node->val = val;
    node->next = NULL;
    return node;
}

int getHashIndex(int key, int capacity) {
    return (key % capacity + capacity) % capacity;
}

void hashMapPut(HashMapNode** map, int capacity, int key, int val) {
    int index = getHashIndex(key, capacity);
    HashMapNode* current = map[index];
    while (current != NULL) {
        if (current->key == key) {
            current->val = val;
            return;
        }
        current = current->next;
    }
    HashMapNode* newNode = createHashMapNode(key, val);
    newNode->next = map[index];
    map[index] = newNode;
}

int hashMapGet(HashMapNode** map, int capacity, int key) {
    int index = getHashIndex(key, capacity);
    HashMapNode* current = map[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->val;
        }
        current = current->next;
    }
    return 0;
}

typedef struct {
    int* nums1;
    int nums1Size;
    int* nums2;
    int nums2Size;
    HashMapNode** freqMap;
    int mapCapacity;
} TwoSum;

TwoSum* twoSumCreate(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    TwoSum* obj = (TwoSum*)malloc(sizeof(TwoSum));
    obj->nums1Size = nums1Size;
    obj->nums2Size = nums2Size;

    obj->nums1 = (int*)malloc(sizeof(int) * nums1Size);
    memcpy(obj->nums1, nums1, sizeof(int) * nums1Size);

    obj->nums2 = (int*)malloc(sizeof(int) * nums2Size);
    memcpy(obj->nums2, nums2, sizeof(int) * nums2Size);

    obj->mapCapacity = 2003; 
    obj->freqMap = (HashMapNode**)calloc(obj->mapCapacity, sizeof(HashMapNode*));

    for (int i = 0; i < nums2Size; i++) {
        int currentVal = obj->nums2[i];
        int currentFreq = hashMapGet(obj->freqMap, obj->mapCapacity, currentVal);
        hashMapPut(obj->freqMap, obj->mapCapacity, currentVal, currentFreq + 1);
    }

    return obj;
}

void twoSumAdd(TwoSum* obj, int index, int val) {
    int oldVal = obj->nums2[index];
    int oldFreq = hashMapGet(obj->freqMap, obj->mapCapacity, oldVal);
    hashMapPut(obj->freqMap, obj->mapCapacity, oldVal, oldFreq - 1);

    obj->nums2[index] += val;

    int newVal = obj->nums2[index];
    int newFreq = hashMapGet(obj->freqMap, obj->mapCapacity, newVal);
    hashMapPut(obj->freqMap, obj->mapCapacity, newVal, newFreq + 1);
}

int twoSumCount(TwoSum* obj, int val) {
    int totalPairs = 0;
    for (int i = 0; i < obj->nums1Size; i++) {
        int target = val - obj->nums1[i];
        totalPairs += hashMapGet(obj->freqMap, obj->mapCapacity, target);
    }
    return totalPairs;
}

void twoSumFree(TwoSum* obj) {
    free(obj->nums1);
    free(obj->nums2);

    for (int i = 0; i < obj->mapCapacity; i++) {
        HashMapNode* current = obj->freqMap[i];
        while (current != NULL) {
            HashMapNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(obj->freqMap);
    free(obj);
}