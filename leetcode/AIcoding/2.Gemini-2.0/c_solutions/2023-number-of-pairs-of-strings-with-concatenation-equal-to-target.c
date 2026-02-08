#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numOfPairs(char ** nums, int numsSize, char * target) {
    int count = 0;
    int targetLen = strlen(target);
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i == j) continue;
            int len1 = strlen(nums[i]);
            int len2 = strlen(nums[j]);
            if (len1 + len2 == targetLen) {
                char *concatenated = (char *)malloc(len1 + len2 + 1);
                strcpy(concatenated, nums[i]);
                strcat(concatenated, nums[j]);
                if (strcmp(concatenated, target) == 0) {
                    count++;
                }
                free(concatenated);
            }
        }
    }
    return count;
}