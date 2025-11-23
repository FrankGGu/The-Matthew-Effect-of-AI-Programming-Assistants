int beautifulSplits(int* nums, int numsSize) {
    int count = 0;

    for (int i = 1; i < numsSize; i++) {
        int leftMax = 0;
        for (int j = 0; j < i; j++) {
            if (nums[j] > leftMax) {
                leftMax = nums[j];
            }
        }

        int rightMin = nums[i];
        for (int k = i; k < numsSize; k++) {
            if (nums[k] < rightMin) {
                rightMin = nums[k];
            }
        }

        if (leftMax < rightMin) {
            count++;
        }
    }

    return count;
}