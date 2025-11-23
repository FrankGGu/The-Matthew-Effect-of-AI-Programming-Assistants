long long maximumTripletValue(int* nums, int numsSize) {
    long long maxTriplet = 0;
    int maxDiff = 0;
    int maxNum = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (maxDiff > 0) {
            long long current = (long long)maxDiff * nums[i];
            if (current > maxTriplet) {
                maxTriplet = current;
            }
        }

        if (maxNum - nums[i] > maxDiff) {
            maxDiff = maxNum - nums[i];
        }

        if (nums[i] > maxNum) {
            maxNum = nums[i];
        }
    }

    return maxTriplet;
}