/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* getSneakyNumbers(int* nums, int numsSize, int* returnSize) {
    int *seen = (int*)calloc(numsSize + 1, sizeof(int));
    int *result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    int idx = 0;

    for (int i = 0; i < numsSize; i++) {
        if (seen[nums[i]] == 1) {
            result[idx++] = nums[i];
        }
        seen[nums[i]] = 1;
    }

    free(seen);
    return result;
}