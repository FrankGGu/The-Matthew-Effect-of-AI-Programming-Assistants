#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* kthDistinct(char** arr, int arrSize, int k) {
    char** distinct = (char**)malloc(arrSize * sizeof(char*));
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        int isDistinct = 1;
        for (int j = 0; j < arrSize; j++) {
            if (i != j && strcmp(arr[i], arr[j]) == 0) {
                isDistinct = 0;
                break;
            }
        }
        if (isDistinct) {
            distinct[count++] = arr[i];
        }
    }

    if (k <= count) {
        return distinct[k - 1];
    } else {
        return NULL;
    }
}