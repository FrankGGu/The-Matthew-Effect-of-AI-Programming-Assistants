#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    char *str1 = *(char **)a;
    char *str2 = *(char **)b;
    char temp1[25];
    char temp2[25];

    strcpy(temp1, str1);
    strcat(temp1, str2);

    strcpy(temp2, str2);
    strcat(temp2, str1);

    return strcmp(temp2, temp1);
}

char * largestNumber(int* nums, int numsSize){
    char **str_nums = (char **)malloc(numsSize * sizeof(char *));
    for (int i = 0; i < numsSize; i++) {
        str_nums[i] = (char *)malloc(11 * sizeof(char));
        sprintf(str_nums[i], "%d", nums[i]);
    }

    qsort(str_nums, numsSize, sizeof(char *), compare);

    char *result = (char *)malloc(1001 * sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < numsSize; i++) {
        strcat(result, str_nums[i]);
    }

    int i = 0;
    while (result[i] == '0' && result[i+1] != '\0') {
        i++;
    }

    if (i > 0) {
        memmove(result, result + i, strlen(result) - i + 1);
    }

    if (result[0] == '\0') {
        result[0] = '0';
        result[1] = '\0';
    }

    for(int i = 0; i < numsSize; i++){
        free(str_nums[i]);
    }
    free(str_nums);

    return result;
}