#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfPairs(char** nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i != j) {
                char* combined = (char*)malloc(strlen(nums[i]) + strlen(nums[j]) + 1);
                strcpy(combined, nums[i]);
                strcat(combined, nums[j]);
                if (strlen(combined) == 0) {
                    free(combined);
                    continue;
                }
                int targetLen = strlen(combined);
                char* target = (char*)malloc(targetLen + 1);
                strcpy(target, combined);
                int found = 0;
                for (int k = 0; k < numsSize; k++) {
                    if (strlen(nums[k]) == targetLen && strcmp(nums[k], target) == 0) {
                        found = 1;
                        break;
                    }
                }
                free(target);
                free(combined);
                if (found) {
                    count++;
                }
            }
        }
    }
    return count;
}