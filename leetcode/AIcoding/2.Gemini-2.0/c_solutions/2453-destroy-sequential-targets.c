#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int destroyTargets(int* nums, int numsSize, int space) {
    int maxCount = 0;
    int result = -1;
    int* count = (int*)malloc(space * sizeof(int));
    int* first = (int*)malloc(space * sizeof(int));
    for (int i = 0; i < space; i++) {
        count[i] = 0;
        first[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        int remainder = nums[i] % space;
        count[remainder]++;
        if (first[remainder] == -1 || nums[i] < first[remainder]) {
            first[remainder] = nums[i];
        }
    }

    for (int i = 0; i < space; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
            result = first[i];
        } else if (count[i] == maxCount) {
            if (first[i] < result || result == -1) {
                result = first[i];
            }
        }
    }

    free(count);
    free(first);
    return result;
}