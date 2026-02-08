#include <stdio.h>
#include <stdlib.h>

int* createArray(int size) {
    int* arr = (int*)malloc(size * sizeof(int));
    return arr;
}

void freeArray(int* arr) {
    free(arr);
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

bool isPossible(int* nums, int numsSize) {
    int* count = (int*)malloc(numsSize * sizeof(int));
    int* appendable = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        count[i] = 1;
        appendable[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        if (count[i] == 0) continue;
        int val = nums[i];
        int next = val + 1;
        int j = i + 1;
        while (j < numsSize && nums[j] == next) {
            if (appendable[j] == 0) {
                appendable[j] = 1;
                count[i]++;
                count[j]--;
                break;
            }
            j++;
        }
        if (j == numsSize || nums[j] != next) {
            int k = i + 1;
            while (k < numsSize && nums[k] == val + 1) {
                if (count[k] > 0) {
                    count[k]--;
                    count[i]++;
                    break;
                }
                k++;
            }
            if (k == numsSize || nums[k] != val + 1) {
                free(count);
                free(appendable);
                return false;
            }
        }
    }

    free(count);
    free(appendable);
    return true;
}