#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findTheOriginalArray(int* pref, int prefSize, int* returnSize){
    int* arr = (int*)malloc(prefSize * sizeof(int));
    *returnSize = prefSize;

    arr[0] = pref[0];
    for (int i = 1; i < prefSize; i++) {
        arr[i] = pref[i] ^ pref[i - 1];
    }

    return arr;
}