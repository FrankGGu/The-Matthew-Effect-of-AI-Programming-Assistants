int minimumDeletions(int* nums, int numsSize) {
    int minIndex = 0, maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[minIndex]) minIndex = i;
        if (nums[i] > nums[maxIndex]) maxIndex = i;
    }
    int left = fmin(minIndex, maxIndex) + 1;
    int right = fmax(minIndex, maxIndex) + 1;
    int totalDeletions = numsSize - fmax(left, numsSize - right);
    return fmin(totalDeletions, fmin(left, right));
}