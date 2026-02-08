void rearrangeArray(int* nums, int numsSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int posIndex = 0, negIndex = 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            result[posIndex] = nums[i];
            posIndex += 2;
        } else {
            result[negIndex] = nums[i];
            negIndex += 2;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        nums[i] = result[i];
    }

    free(result);
}