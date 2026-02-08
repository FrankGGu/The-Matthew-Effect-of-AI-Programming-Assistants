/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* colorTheArray(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* nums = (int*)calloc(n, sizeof(int));
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int count = 0;
    for (int i = 0; i < queriesSize; i++) {
        int index = queries[i][0];
        int color = queries[i][1];

        if (nums[index] != 0) {
            if (index > 0 && nums[index] == nums[index - 1]) {
                count--;
            }
            if (index < n - 1 && nums[index] == nums[index + 1]) {
                count--;
            }
        }

        nums[index] = color;

        if (index > 0 && nums[index] == nums[index - 1]) {
            count++;
        }
        if (index < n - 1 && nums[index] == nums[index + 1]) {
            count++;
        }

        result[i] = count;
    }

    free(nums);
    return result;
}