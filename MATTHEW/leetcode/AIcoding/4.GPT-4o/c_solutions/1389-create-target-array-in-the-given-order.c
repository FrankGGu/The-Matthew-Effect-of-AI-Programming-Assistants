int* createTargetArray(int* nums, int numsSize, int* index, int indexSize, int* returnSize) {
    int* target = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j > index[i]; j--) {
            target[j] = target[j - 1];
        }
        target[index[i]] = nums[i];
    }

    return target;
}