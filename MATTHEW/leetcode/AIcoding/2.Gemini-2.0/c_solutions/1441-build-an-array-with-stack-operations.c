#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** buildArray(int target[], int targetSize, int n, int* returnSize){
    char ** result = (char **)malloc(sizeof(char*) * (2 * n));
    *returnSize = 0;
    int current = 1;
    for(int i = 0; i < targetSize; i++){
        while(current < target[i]){
            result[*returnSize] = (char*)malloc(sizeof(char) * 5);
            strcpy(result[*returnSize], "Push");
            (*returnSize)++;
            result[*returnSize] = (char*)malloc(sizeof(char) * 5);
            strcpy(result[*returnSize], "Pop");
            (*returnSize)++;
            current++;
        }
        result[*returnSize] = (char*)malloc(sizeof(char) * 5);
        strcpy(result[*returnSize], "Push");
        (*returnSize)++;
        current++;
    }
    return result;
}