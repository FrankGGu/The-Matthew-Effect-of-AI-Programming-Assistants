#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findIntegers(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            count++;
        }
    }
    return count;
}

int* destroyTargets(int* nums, int numsSize, int space) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int index = 0;

    int* unique = (int*)malloc(numsSize * sizeof(int));
    int uniqueSize = 0;

    for (int i = 0; i < numsSize; i++) {
        int isUnique = 1;
        for (int j = 0; j < uniqueSize; j++) {
            if (nums[i] == unique[j]) {
                isUnique = 0;
                break;
            }
        }
        if (isUnique) {
            unique[uniqueSize++] = nums[i];
        }
    }

    qsort(unique, uniqueSize, sizeof(int), compare);

    for (int i = 0; i < uniqueSize; i++) {
        int target = unique[i];
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((nums[j] - target) % space == 0) {
                count++;
            }
        }
        if (count > 0) {
            result[index++] = target;
        }
    }

    free(unique);
    return result;
}