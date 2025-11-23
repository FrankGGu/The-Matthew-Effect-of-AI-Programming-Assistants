int maximumTripletValue(int* nums, int numsSize) {
    int maxValue = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                int value = (nums[i] - nums[j]) + nums[k];
                if (value > maxValue) {
                    maxValue = value;
                }
            }
        }
    }
    return maxValue;
}