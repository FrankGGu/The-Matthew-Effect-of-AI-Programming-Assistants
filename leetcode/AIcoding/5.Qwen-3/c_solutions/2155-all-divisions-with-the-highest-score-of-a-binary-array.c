#include <stdio.h>
#include <stdlib.h>

int* allDivisions(int* nums, int numsSize, int* returnSize) {
    int totalOnes = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            totalOnes++;
        }
    }

    int maxScore = 0;
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        int score = (totalOnes - (i + 1)) + (i + 1 - totalOnes);
        if (score > maxScore) {
            maxScore = score;
            count = 1;
        } else if (score == maxScore) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        int score = (totalOnes - (i + 1)) + (i + 1 - totalOnes);
        if (score == maxScore) {
            result[index++] = i;
        }
    }

    *returnSize = count;
    return result;
}