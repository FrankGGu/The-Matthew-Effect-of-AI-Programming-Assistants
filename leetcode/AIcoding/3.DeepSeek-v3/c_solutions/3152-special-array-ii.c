/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* isArraySpecial(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefix = (int*)malloc(numsSize * sizeof(int));
    prefix[0] = 0;

    for (int i = 1; i < numsSize; i++) {
        prefix[i] = prefix[i-1];
        if ((nums[i] % 2) == (nums[i-1] % 2)) {
            prefix[i]++;
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int from = queries[i][0];
        int to = queries[i][1];

        if (from == to) {
            result[i] = 1;
        } else {
            int violations = prefix[to] - prefix[from];
            result[i] = (violations == 0) ? 1 : 0;
        }
    }

    free(prefix);
    return result;
}