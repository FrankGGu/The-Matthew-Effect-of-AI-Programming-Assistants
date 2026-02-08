#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* distance(int* arr, int arrSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    long long* prefix_sum = (long long*)malloc((arrSize + 1) * sizeof(long long));
    prefix_sum[0] = 0;
    for (int i = 0; i < arrSize; i++) {
        prefix_sum[i + 1] = prefix_sum[i] + arr[i];
    }

    for (int i = 0; i < arrSize; i++) {
        long long sum = 0;
        for (int j = 0; j < arrSize; j++) {
            sum += abs(arr[i] - arr[j]);
        }
        result[i] = (int)sum;
    }

    free(prefix_sum);
    return result;
}