int minimumDeletions(int* nums, int numsSize) {
    if (numsSize <= 2) return numsSize;

    int minIndex = 0, maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[minIndex]) minIndex = i;
        if (nums[i] > nums[maxIndex]) maxIndex = i;
    }

    int left = minIndex < maxIndex ? minIndex : maxIndex;
    int right = minIndex > maxIndex ? minIndex : maxIndex;

    int option1 = right + 1;
    int option2 = numsSize - left;
    int option3 = (left + 1) + (numsSize - right);

    int min = option1;
    if (option2 < min) min = option2;
    if (option3 < min) min = option3;

    return min;
}