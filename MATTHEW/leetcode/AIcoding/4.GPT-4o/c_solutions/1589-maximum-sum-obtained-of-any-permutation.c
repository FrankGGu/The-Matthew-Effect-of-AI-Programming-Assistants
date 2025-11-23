int maxSumRangeQuery(int* nums, int numsSize, int** requests, int requestsSize, int* requestsColSize) {
    int* count = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < requestsSize; i++) {
        count[requests[i][0]]++;
        if (requests[i][1] + 1 < numsSize) {
            count[requests[i][1] + 1]--;
        }
    }

    for (int i = 1; i < numsSize; i++) {
        count[i] += count[i - 1];
    }

    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*))cmp);
    qsort(count, numsSize, sizeof(int), (int(*)(const void*, const void*))cmp);

    long long result = 0;
    const int MOD = 1e9 + 7;
    for (int i = 0; i < numsSize; i++) {
        result = (result + (long long)nums[i] * count[i]) % MOD;
    }

    free(count);
    return (int)result;
}

int cmp(const int* a, const int* b) {
    return *b - *a;
}