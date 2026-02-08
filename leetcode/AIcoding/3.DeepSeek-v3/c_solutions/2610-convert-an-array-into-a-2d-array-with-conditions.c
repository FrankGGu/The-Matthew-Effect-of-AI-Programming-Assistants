int** findMatrix(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int freq[201] = {0};
    int maxFreq = 0;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
        }
    }

    int** result = (int**)malloc(maxFreq * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxFreq * sizeof(int));
    *returnSize = maxFreq;

    for (int i = 0; i < maxFreq; i++) {
        result[i] = (int*)malloc(numsSize * sizeof(int));
        (*returnColumnSizes)[i] = 0;
    }

    for (int num = 1; num <= 200; num++) {
        for (int row = 0; row < freq[num]; row++) {
            result[row][(*returnColumnSizes)[row]] = num;
            (*returnColumnSizes)[row]++;
        }
    }

    return result;
}