int** findIntersection(int** nums, int numsSize, int* numsColSize, int* returnSize, int** returnColumnSizes) {
    int freq[1001] = {0};

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            freq[nums[i][j]]++;
        }
    }

    int count = 0;
    for (int i = 1; i <= 1000; i++) {
        if (freq[i] == numsSize) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));

    int index = 0;
    for (int i = 1; i <= 1000; i++) {
        if (freq[i] == numsSize) {
            result[index] = (int*)malloc(sizeof(int));
            result[index][0] = i;
            (*returnColumnSizes)[index] = 1;
            index++;
        }
    }

    *returnSize = count;
    return result;
}