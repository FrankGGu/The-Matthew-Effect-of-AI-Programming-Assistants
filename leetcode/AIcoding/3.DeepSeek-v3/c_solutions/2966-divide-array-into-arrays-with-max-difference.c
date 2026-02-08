/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** divideArray(int* nums, int numsSize, int k, int* returnSize, int** returnColumnSizes) {
    if (numsSize % 3 != 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(nums, numsSize, sizeof(int), cmpfunc);

    int n = numsSize / 3;
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(3 * sizeof(int));
        (*returnColumnSizes)[i] = 3;
    }

    for (int i = 0; i < n; i++) {
        int start = i * 3;
        if (nums[start + 2] - nums[start] > k) {
            *returnSize = 0;
            for (int j = 0; j < n; j++) {
                free(result[j]);
            }
            free(result);
            free(*returnColumnSizes);
            return NULL;
        }
        result[i][0] = nums[start];
        result[i][1] = nums[start + 1];
        result[i][2] = nums[start + 2];
    }

    *returnSize = n;
    return result;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}