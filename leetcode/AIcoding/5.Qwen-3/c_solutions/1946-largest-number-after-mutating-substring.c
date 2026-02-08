#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeTrailingZeros(char* s) {
    int len = strlen(s);
    int i = len - 1;
    while (i >= 0 && s[i] == '0') {
        i--;
    }
    s[i + 1] = '\0';
    return s;
}

char* largestNumber(char* nums, int numsSize) {
    char** strNums = (char**)malloc(numsSize * sizeof(char*));
    for (int i = 0; i < numsSize; i++) {
        strNums[i] = (char*)malloc(20 * sizeof(char));
        sprintf(strNums[i], "%d", nums[i]);
    }

    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (strcmp(strNums[j], strNums[j + 1]) < 0) {
                char* temp = strNums[j];
                strNums[j] = strNums[j + 1];
                strNums[j + 1] = temp;
            }
        }
    }

    char* result = (char*)malloc(20 * numsSize * sizeof(char));
    strcpy(result, "");

    for (int i = 0; i < numsSize; i++) {
        strcat(result, strNums[i]);
    }

    if (result[0] == '0') {
        return "0";
    }

    return result;
}

char* maximumNumber(char* s, int* nums, int numsSize) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    strcpy(result, s);

    for (int i = 0; i < len; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (result[i] < nums[j] + '0') {
                result[i] = nums[j] + '0';
                break;
            }
        }
    }

    return removeTrailingZeros(result);
}