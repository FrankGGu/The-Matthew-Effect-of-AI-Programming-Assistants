/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int rangeSum(int* nums, int numsSize, int n, int left, int right){
    int *subSums = (int*)malloc(n * (n + 1) / 2 * sizeof(int));
    int idx = 0;

    for (int i = 0; i < n; i++) {
        int sum = 0;
        for (int j = i; j < n; j++) {
            sum += nums[j];
            subSums[idx++] = sum;
        }
    }

    qsort(subSums, idx, sizeof(int), compare);

    long long result = 0;
    int MOD = 1000000007;
    for (int i = left - 1; i < right; i++) {
        result = (result + subSums[i]) % MOD;
    }

    free(subSums);
    return result;
}