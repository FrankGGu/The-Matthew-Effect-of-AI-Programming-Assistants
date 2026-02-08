#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * findDifferentBinaryString(char ** nums, int numsSize){
    char * result = (char*)malloc(sizeof(char) * (numsSize + 1));
    for (int i = 0; i < numsSize; i++) {
        result[i] = (nums[i][i] == '0') ? '1' : '0';
    }
    result[numsSize] = '\0';
    return result;
}