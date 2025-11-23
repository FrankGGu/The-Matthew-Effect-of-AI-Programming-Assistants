/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findErrorNums(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int* count = (int*)calloc(numsSize + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    for (int i = 1; i <= numsSize; i++) {
        if (count[i] == 2) {
            result[0] = i;
        }
        if (count[i] == 0) {
            result[1] = i;
        }
    }

    free(count);
    return result;
}