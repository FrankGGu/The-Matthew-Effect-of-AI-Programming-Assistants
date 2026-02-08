typedef struct {
    int *nums;
    int size;
} Array;

Array findArray(int* sum, int sumSize) {
    Array result;
    result.nums = (int*)malloc((sumSize - 1) * sizeof(int));
    result.size = sumSize - 1;

    for (int i = 0; i < sumSize - 1; i++) {
        result.nums[i] = sum[i + 1] - sum[i];
    }

    return result;
}