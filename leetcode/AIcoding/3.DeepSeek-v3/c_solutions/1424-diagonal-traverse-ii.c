/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findDiagonalOrder(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    int maxSum = 0;
    int total = 0;

    for (int i = 0; i < numsSize; i++) {
        total += numsColSize[i];
        maxSum = (maxSum > i + numsColSize[i]) ? maxSum : i + numsColSize[i];
    }

    int** buckets = (int**)malloc((maxSum + 1) * sizeof(int*));
    int* sizes = (int*)calloc(maxSum + 1, sizeof(int));
    int* capacities = (int*)malloc((maxSum + 1) * sizeof(int));

    for (int i = 0; i <= maxSum; i++) {
        capacities[i] = 10;
        buckets[i] = (int*)malloc(capacities[i] * sizeof(int));
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            int sum = i + j;
            if (sizes[sum] >= capacities[sum]) {
                capacities[sum] *= 2;
                buckets[sum] = (int*)realloc(buckets[sum], capacities[sum] * sizeof(int));
            }
            buckets[sum][sizes[sum]++] = nums[i][j];
        }
    }

    int* result = (int*)malloc(total * sizeof(int));
    int idx = 0;

    for (int sum = 0; sum <= maxSum; sum++) {
        for (int i = sizes[sum] - 1; i >= 0; i--) {
            result[idx++] = buckets[sum][i];
        }
        free(buckets[sum]);
    }

    free(buckets);
    free(sizes);
    free(capacities);

    *returnSize = total;
    return result;
}