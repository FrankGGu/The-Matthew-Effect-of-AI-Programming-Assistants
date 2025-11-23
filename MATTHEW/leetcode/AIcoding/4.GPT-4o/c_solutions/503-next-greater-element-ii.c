int* nextGreaterElements(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < 2 * numsSize; i++) {
        int currentIndex = i % numsSize;
        for (int j = 1; j < numsSize; j++) {
            int nextIndex = (currentIndex + j) % numsSize;
            if (nums[nextIndex] > nums[currentIndex]) {
                result[currentIndex] = nums[nextIndex];
                break;
            }
        }
    }

    return result;
}