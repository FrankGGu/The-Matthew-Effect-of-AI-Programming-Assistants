#include <stdlib.h> // Required for malloc and free

int* getAverages(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    *returnSize = n;

    int* avgs = (int*) malloc(n * sizeof(int));
    if (avgs == NULL) {
        return NULL; 
    }

    for (int i = 0; i < n; i++) {
        avgs[i] = -1;
    }

    if (2 * k + 1 > n) {
        return avgs;
    }

    long long* prefixSum = (long long*) malloc((n + 1) * sizeof(long long));
    if (prefixSum == NULL) {
        free(avgs);
        return NULL;
    }

    prefixSum[0] = 0;
    for (int i = 0; i < n; i++) {
        prefixSum[i+1] = prefixSum[i] + nums[i];
    }

    for (int i = k; i < n - k; i++) {
        long long current_sum = prefixSum[i + k + 1] - prefixSum[i - k];
        avgs[i] = (int)(current_sum / (2 * k + 1));
    }

    free(prefixSum);
    return avgs;
}