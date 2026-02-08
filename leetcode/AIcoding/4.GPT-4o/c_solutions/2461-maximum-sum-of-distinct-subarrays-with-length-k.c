#include <stdio.h>
#include <stdlib.h>

int maximumSum(int* arr, int arrSize, int k) {
    int maxSum = 0;
    int currentSum = 0;
    int* freq = (int*)calloc(100001, sizeof(int));
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        if (i >= k) {
            currentSum -= arr[i - k];
            freq[arr[i - k]]--;
            if (freq[arr[i - k]] == 0) count--;
        }
        currentSum += arr[i];
        freq[arr[i]]++;
        if (freq[arr[i]] == 1) count++;

        if (i >= k - 1 && count == k) {
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
        }
    }

    free(freq);
    return maxSum;
}