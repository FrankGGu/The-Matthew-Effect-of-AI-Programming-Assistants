#include <stdio.h>
#include <stdlib.h>

int* splitEvenNumber(int n, int* returnSize) {
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    int index = 0;
    for (int i = 2; i <= n; i += 2) {
        result[index++] = i;
    }
    return result;
}