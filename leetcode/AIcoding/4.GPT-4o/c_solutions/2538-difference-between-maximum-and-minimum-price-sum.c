int maximumDifference(int* nums, int numsSize) {
    int maxDiff = -1;
    int minPrice = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > minPrice) {
            int diff = nums[i] - minPrice;
            if (diff > maxDiff) {
                maxDiff = diff;
            }
        } else {
            minPrice = nums[i];
        }
    }

    return maxDiff;
}