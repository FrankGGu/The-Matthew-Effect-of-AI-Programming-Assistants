#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *str1 = *(char **)a;
    char *str2 = *(char **)b;
    char combined1[200];
    char combined2[200];
    strcpy(combined1, str1);
    strcat(combined1, str2);
    strcpy(combined2, str2);
    strcat(combined2, str1);
    return strcmp(combined2, combined1);
}

char * largestNumber(int* nums, int numsSize){
    char **numStrs = (char **)malloc(numsSize * sizeof(char *));
    for (int i = 0; i < numsSize; i++) {
        numStrs[i] = (char *)malloc(11 * sizeof(char));
        sprintf(numStrs[i], "%d", nums[i]);
    }

    qsort(numStrs, numsSize, sizeof(char *), compare);

    char *result = (char *)malloc(numsSize * 11 + 1);
    result[0] = '\0';
    for (int i = 0; i < numsSize; i++) {
        strcat(result, numStrs[i]);
    }

    if (result[0] == '0' && result[1] == '\0') {
        return result;
    }

    int allZeros = 1;
    for(int i = 0; i < strlen(result); i++){
        if(result[i] != '0'){
            allZeros = 0;
            break;
        }
    }
    if(allZeros){
        result[1] = '\0';
    }

    for (int i = 0; i < numsSize; i++) {
        free(numStrs[i]);
    }
    free(numStrs);

    return result;
}