#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int* data;
    int size;
} IntArray;

IntArray* createIntArray(int capacity) {
    IntArray* arr = (IntArray*)malloc(sizeof(IntArray));
    arr->data = (int*)malloc(capacity * sizeof(int));
    arr->size = 0;
    return arr;
}

void freeIntArray(IntArray* arr) {
    free(arr->data);
    free(arr);
}

void addToIntArray(IntArray* arr, int value) {
    arr->data[arr->size++] = value;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int* getSortedGcdPairs(int* nums, int numsSize, int** queries, int queriesSize, int* queryColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* sortedNums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sortedNums[i] = nums[i];
    }
    qsort(sortedNums, numsSize, sizeof(int), compare);

    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (sortedNums[i] > maxNum) {
            maxNum = sortedNums[i];
        }
    }

    int* freq = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[sortedNums[i]]++;
    }

    int* count = (int*)calloc(maxNum + 1, sizeof(int));
    for (int i = 1; i <= maxNum; i++) {
        for (int j = i; j <= maxNum; j += i) {
            count[i] += freq[j];
        }
    }

    for (int i = 1; i <= maxNum; i++) {
        count[i] = count[i] * (count[i] - 1) / 2;
    }

    for (int i = 1; i <= maxNum; i++) {
        for (int j = 2 * i; j <= maxNum; j += i) {
            count[i] -= count[j];
        }
    }

    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i][0];
        int k = queries[i][1];
        int total = 0;
        int found = 0;
        for (int g = 1; g <= maxNum; g++) {
            if (count[g] >= k) {
                found = 1;
                break;
            }
            total += count[g];
        }
        result[i] = found ? g : -1;
    }

    *returnSize = queriesSize;
    free(freq);
    free(count);
    free(sortedNums);
    return result;
}