#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* lastVisitedIntegers(char** words, int wordsSize, int* returnSize) {
    int* nums = (int*)malloc(wordsSize * sizeof(int));
    int numsSize = 0;
    int* ans = (int*)malloc(wordsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (words[i][0] >= '0' && words[i][0] <= '9') {
            nums[numsSize++] = atoi(words[i]);
        } else {
            int k = atoi(words[i] + 4);
            if (k > numsSize) {
                ans[(*returnSize)++] = -1;
            } else {
                ans[(*returnSize)++] = nums[numsSize - k];
            }
        }
    }

    nums = (int*)realloc(ans, (*returnSize) * sizeof(int));

    return nums;
}