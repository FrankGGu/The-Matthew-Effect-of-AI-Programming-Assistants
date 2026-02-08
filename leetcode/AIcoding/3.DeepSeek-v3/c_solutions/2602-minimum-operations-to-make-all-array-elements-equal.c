int* minOperations(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));
    if (result == NULL) return NULL;

    qsort(nums, numsSize, sizeof(int), cmpfunc);

    long long* prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (int i = 0; i < queriesSize; i++) {
        int q = queries[i];
        int idx = binarySearch(nums, numsSize, q);

        long long leftSum = (long long)q * idx - prefix[idx];
        long long rightSum = (prefix[numsSize] - prefix[idx]) - (long long)q * (numsSize - idx);

        result[i] = (int)(leftSum + rightSum);
    }

    free(prefix);
    return result;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int binarySearch(int* nums, int numsSize, int target) {
    int left = 0, right = numsSize;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}