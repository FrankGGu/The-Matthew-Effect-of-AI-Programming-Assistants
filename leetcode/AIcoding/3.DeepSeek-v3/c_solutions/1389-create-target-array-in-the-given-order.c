int* createTargetArray(int* nums, int numsSize, int* index, int indexSize, int* returnSize) {
    *returnSize = numsSize;
    int* target = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        target[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        if (target[index[i]] == -1) {
            target[index[i]] = nums[i];
        } else {
            for (int j = numsSize - 1; j > index[i]; j--) {
                target[j] = target[j - 1];
            }
            target[index[i]] = nums[i];
        }
    }

    return target;
}