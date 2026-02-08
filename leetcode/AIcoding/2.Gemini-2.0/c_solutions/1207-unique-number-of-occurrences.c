#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countOccurrences(int* arr, int arrSize, int* returnSize) {
    int* counts = (int*)malloc(sizeof(int) * 2001);
    for (int i = 0; i < 2001; i++) {
        counts[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        counts[arr[i] + 1000]++;
    }

    *returnSize = 2001;
    return counts;
}

bool uniqueOccurrences(int* arr, int arrSize){
    int returnSize;
    int* counts = countOccurrences(arr, arrSize, &returnSize);

    int* seen = (int*)malloc(sizeof(int) * (arrSize + 1));
    for(int i = 0; i <= arrSize; i++){
        seen[i] = 0;
    }

    for(int i = 0; i < returnSize; i++){
        if(counts[i] > 0){
            if(seen[counts[i]] == 1){
                free(counts);
                free(seen);
                return false;
            }
            seen[counts[i]] = 1;
        }
    }

    free(counts);
    free(seen);
    return true;
}