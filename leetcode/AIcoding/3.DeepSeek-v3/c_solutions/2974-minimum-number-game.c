int* numberGame(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* arr = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] > nums[j]) {
                int temp = nums[i];
                nums[i] = nums[j];
                nums[j] = temp;
            }
        }
    }
    for (int i = 0; i < numsSize; i += 2) {
        arr[i] = nums[i + 1];
        arr[i + 1] = nums[i];
    }
    return arr;
}