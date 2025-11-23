#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    int num1 = *(int*)a;
    int num2 = *(int*)b;
    char s1[12], s2[12];
    sprintf(s1, "%d", num1);
    sprintf(s2, "%d", num2);
    return strcmp(s1, s2);
}

int* sortJumbled(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    memcpy(result, arr, arrSize * sizeof(int));
    qsort(result, arrSize, sizeof(int), compare);
    *returnSize = arrSize;
    return result;
}