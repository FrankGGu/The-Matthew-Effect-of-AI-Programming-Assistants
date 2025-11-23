#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * optimalDivision(int* nums, int numsSize){
    if (numsSize == 1) {
        char *result = (char *)malloc(12);
        sprintf(result, "%d", nums[0]);
        return result;
    }

    if (numsSize == 2) {
        char *result = (char *)malloc(24);
        sprintf(result, "%d/%d", nums[0], nums[1]);
        return result;
    }

    char *result = (char *)malloc(numsSize * 12 + 10);
    sprintf(result, "%d/(", nums[0]);
    int len = strlen(result);
    for (int i = 1; i < numsSize; i++) {
        sprintf(result + len, "%d", nums[i]);
        len += strlen(result + len);
        if (i < numsSize - 1) {
            sprintf(result + len, "/");
            len += strlen(result + len);
        }
    }
    sprintf(result + len, ")");
    return result;
}