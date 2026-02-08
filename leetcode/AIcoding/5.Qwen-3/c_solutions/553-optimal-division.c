#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** optimalDivision(char* nums, int numsSize, int* returnSize) {
    if (numsSize == 1) {
        *returnSize = 1;
        char** result = (char**)malloc(sizeof(char*));
        result[0] = (char*)malloc(strlen(nums) + 1);
        strcpy(result[0], nums);
        return result;
    }

    if (numsSize == 2) {
        *returnSize = 1;
        char** result = (char**)malloc(sizeof(char*));
        result[0] = (char*)malloc(strlen(nums) + 2);
        sprintf(result[0], "%s/%s", nums, nums + strlen(nums) + 1);
        return result;
    }

    *returnSize = 1;
    char** result = (char**)malloc(sizeof(char*));
    result[0] = (char*)malloc(200);
    sprintf(result[0], "%s/", nums);

    for (int i = 1; i < numsSize - 1; i++) {
        char* temp = (char*)malloc(200);
        sprintf(temp, "%s%s/", result[0], nums + strlen(nums) + 1);
        free(result[0]);
        result[0] = temp;
    }

    char* final = (char*)malloc(200);
    sprintf(final, "%s%s", result[0], nums + strlen(nums) + 1);
    free(result[0]);
    result[0] = final;

    return result;
}