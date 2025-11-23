#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize){
    int* result = (int*)malloc(sizeof(int) * temperaturesSize);
    *returnSize = temperaturesSize;

    for (int i = 0; i < temperaturesSize; i++) {
        result[i] = 0;
        for (int j = i + 1; j < temperaturesSize; j++) {
            if (temperatures[j] > temperatures[i]) {
                result[i] = j - i;
                break;
            }
        }
    }

    return result;
}