#include <stdlib.h>

struct HashMap {
    int key;
    int value;
    struct HashMap* next;
};

struct HashMap* createNode(int key, int value) {
    struct HashMap* node = (struct HashMap*)malloc(sizeof(struct HashMap));
    node->key = key;
    node->value = value;
    node->next = NULL;
    return node;
}

void insert(struct HashMap** map, int key, int value) {
    int index = abs(key) % 10000;
    struct HashMap* node = createNode(key, value);
    node->next = map[index];
    map[index] = node;
}

int get(struct HashMap** map, int key) {
    int index = abs(key) % 10000;
    struct HashMap* curr = map[index];
    while (curr) {
        if (curr->key == key) {
            return curr->value;
        }
        curr = curr->next;
    }
    return 0;
}

int findShortestSubarray(int* nums, int numsSize) {
    struct HashMap* countMap[10000] = {0};
    int first[10000] = {0};
    int last[10000] = {0};
    int degree = 0;

    for (int i = 0; i < numsSize; i++) {
        insert(countMap, nums[i], get(countMap, nums[i]) + 1);
        if (first[nums[i]] == 0) first[nums[i]] = i + 1;
        last[nums[i]] = i + 1;
        degree = degree < get(countMap, nums[i]) ? get(countMap, nums[i]) : degree;
    }

    int minLength = numsSize;
    for (int i = 0; i < 10000; i++) {
        if (get(countMap, i) == degree) {
            minLength = minLength < (last[i] - first[i] + 1) ? minLength : (last[i] - first[i] + 1);
        }
    }
    return minLength;
}

int findDegree(int* nums, int numsSize) {
    return findShortestSubarray(nums, numsSize);
}