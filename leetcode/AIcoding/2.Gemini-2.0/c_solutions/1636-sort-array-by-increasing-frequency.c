#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int freq;
} Item;

int compare(const void *a, const void *b) {
    Item *itemA = (Item *)a;
    Item *itemB = (Item *)b;

    if (itemA->freq != itemB->freq) {
        return itemA->freq - itemB->freq;
    } else {
        return itemB->val - itemA->val;
    }
}

int* frequencySort(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    Item freqMap[201];
    for (int i = 0; i < 201; i++) {
        freqMap[i].val = i - 100;
        freqMap[i].freq = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        freqMap[nums[i] + 100].freq++;
    }

    Item items[201];
    int itemCount = 0;
    for (int i = 0; i < 201; i++) {
        if (freqMap[i].freq > 0) {
            items[itemCount].val = freqMap[i].val;
            items[itemCount].freq = freqMap[i].freq;
            itemCount++;
        }
    }

    qsort(items, itemCount, sizeof(Item), compare);

    int index = 0;
    for (int i = 0; i < itemCount; i++) {
        for (int j = 0; j < items[i].freq; j++) {
            result[index++] = items[i].val;
        }
    }

    return result;
}