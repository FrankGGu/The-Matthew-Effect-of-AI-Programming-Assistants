int matrixSum(int** nums, int numsSize, int* numsColSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            for (int k = j + 1; k < numsColSize[i]; k++) {
                if (nums[i][j] < nums[i][k]) {
                    int temp = nums[i][j];
                    nums[i][j] = nums[i][k];
                    nums[i][k] = temp;
                }
            }
        }
    }

    for (int j = 0; j < numsColSize[0]; j++) {
        int maxVal = 0;
        for (int i = 0; i < numsSize; i++) {
            if (j < numsColSize[i] && nums[i][j] > maxVal) {
                maxVal = nums[i][j];
            }
        }
        total += maxVal;
    }

    return total;
}