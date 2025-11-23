#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long calculateScore(int* nums, int numsSize, char* s) {
    long long score = 0;
    int* used = (int*)malloc(numsSize * sizeof(int));
    memset(used, 0, numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (s[i] == '1' && used[i] == 0) {
            int maxVal = nums[i];
            int maxIdx = i;
            for (int j = 0; j < numsSize; j++) {
                if (used[j] == 0 && nums[j] > maxVal) {
                    maxVal = nums[j];
                    maxIdx = j;
                }
            }
            score += maxVal;
            used[maxIdx] = 1;

            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == maxVal && j != maxIdx && used[j] == 0) {
                    used[j] = 1;
                    break;
                }
            }
        }
    }

    free(used);
    return score;
}