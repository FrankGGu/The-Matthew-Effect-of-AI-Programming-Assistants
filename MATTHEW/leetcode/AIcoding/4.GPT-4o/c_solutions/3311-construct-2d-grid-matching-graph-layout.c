int** constructGrid(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    int** grid = (int**)malloc(sizeof(int*) * maxNum);
    for (int i = 0; i < maxNum; i++) {
        grid[i] = (int*)malloc(sizeof(int) * maxNum);
        for (int j = 0; j < maxNum; j++) {
            grid[i][j] = 0;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < nums[i]; j++) {
            grid[i][j] = 1;
        }
    }

    *returnSize = maxNum;
    *returnColumnSizes = (int*)malloc(sizeof(int) * maxNum);
    for (int i = 0; i < maxNum; i++) {
        (*returnColumnSizes)[i] = maxNum;
    }

    return grid;
}