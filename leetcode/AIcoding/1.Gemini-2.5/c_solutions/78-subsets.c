int** subsets(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 1 << numsSize;
    int** result = (int**)malloc(*returnSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));

    for (int i = 0; i < *returnSize; i++) {
        int currentSubsetSize = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                currentSubsetSize++;
            }
        }
        result[i] = (int*)malloc(currentSubsetSize * sizeof(int));
        (*returnColumnSizes)[i] = currentSubsetSize;

        int k = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                result[i][k++] = nums[j];
            }
        }
    }

    return result;
}