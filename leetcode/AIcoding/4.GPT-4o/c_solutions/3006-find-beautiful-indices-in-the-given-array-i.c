int findBeautifulIndices(int* nums, int numsSize, int* returnSize) {
    int* indices = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i > 0 && i < numsSize - 1 && nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
            indices[count++] = i;
        }
    }

    *returnSize = count;
    return indices;
}