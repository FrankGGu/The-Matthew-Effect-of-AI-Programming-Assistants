int maximumDifference(int* nums, int numsSize) {
    int maxEven = INT_MIN, maxOdd = INT_MIN;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            if (nums[i] > maxEven) maxEven = nums[i];
        } else {
            if (nums[i] > maxOdd) maxOdd = nums[i];
        }
    }
    return maxEven - maxOdd;
}