#include <stdio.h>
#include <stdlib.h>

int maxJumps(int* arr, int arrSize) {
    int* dp = (int*)malloc(arrSize * sizeof(int));
    int* index = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        index[i] = i;
    }

    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            if (arr[index[j]] > arr[index[i]] && abs(index[j] - index[i]) > 0) {
                int temp = index[j];
                index[j] = index[i];
                index[i] = temp;
            }
        }
    }

    for (int i = 0; i < arrSize; i++) {
        int current = index[i];
        for (int j = 0; j < arrSize; j++) {
            if (arr[current] > arr[index[j]] && abs(current - index[j]) > 0) {
                dp[current] = fmax(dp[current], dp[index[j]] + 1);
            }
        }
    }

    int result = 0;
    for (int i = 0; i < arrSize; i++) {
        result = fmax(result, dp[i]);
    }

    free(dp);
    free(index);
    return result;
}