int maximumCount(int* nums, int numsSize) {
    int posCount = 0;
    int negCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            posCount++;
        } else if (nums[i] < 0) {
            negCount++;
        }
    }

    return (posCount > negCount) ? posCount : negCount;
}