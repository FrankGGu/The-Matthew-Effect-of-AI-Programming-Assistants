#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumDeletions(int* nums, int numsSize) {
    int minIndex = 0, maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[minIndex]) {
            minIndex = i;
        }
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    int a = (minIndex > maxIndex) ? maxIndex : minIndex;
    int b = (minIndex > maxIndex) ? minIndex : maxIndex;

    int option1 = b + 1;
    int option2 = numsSize - a;
    int option3 = (a + 1) + (numsSize - b);

    int min = option1;
    if (option2 < min) {
        min = option2;
    }
    if (option3 < min) {
        min = option3;
    }

    return min;
}