/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int compare(const void* a, const void* b) {
    long long* pa = (long long*)a;
    long long* pb = (long long*)b;
    if (pa[0] != pb[0]) {
        return (pa[0] > pb[0]) ? 1 : -1;
    }
    return (pa[1] > pb[1]) ? 1 : -1;
}

int* smallestTrimmedNumbers(char** nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int maxLen = strlen(nums[0]);

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i][0];
        int trim = queries[i][1];

        long long** arr = (long long**)malloc(numsSize * sizeof(long long*));
        for (int j = 0; j < numsSize; j++) {
            arr[j] = (long long*)malloc(2 * sizeof(long long));
        }

        int start = maxLen - trim;
        for (int j = 0; j < numsSize; j++) {
            long long val = 0;
            for (int pos = start; pos < maxLen; pos++) {
                val = val * 10 + (nums[j][pos] - '0');
            }
            arr[j][0] = val;
            arr[j][1] = j;
        }

        qsort(arr, numsSize, sizeof(long long*), compare);

        result[i] = arr[k - 1][1];

        for (int j = 0; j < numsSize; j++) {
            free(arr[j]);
        }
        free(arr);
    }

    return result;
}