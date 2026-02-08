int* sortJumbled(int* mapping, int mappingSize, int* nums, int numsSize, int* returnSize) {
    int* result = malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i], newNum = 0, place = 1;
        while (num > 0) {
            int digit = num % 10;
            newNum += mapping[digit] * place;
            place *= 10;
            num /= 10;
        }
        result[i] = newNum;
    }

    int* indices = malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    qsort(indices, numsSize, sizeof(int), [](const void* a, const void* b) {
        return result[*(int*)a] - result[*(int*)b];
    });

    int* sortedNums = malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sortedNums[i] = nums[indices[i]];
    }

    free(result);
    free(indices);
    *returnSize = numsSize;
    return sortedNums;
}