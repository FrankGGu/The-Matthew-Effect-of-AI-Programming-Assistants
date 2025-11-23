int continuousSubarrays(int* nums, int numsSize) {
    int left = 0, count = 0;
    int minVal = nums[0], maxVal = nums[0];

    for (int right = 0; right < numsSize; right++) {
        if (right > 0) {
            minVal = fmin(minVal, nums[right]);
            maxVal = fmax(maxVal, nums[right]);
        }
        while (maxVal - minVal > 2) {
            left++;
            minVal = nums[left];
            maxVal = nums[left];
            for (int i = left; i <= right; i++) {
                minVal = fmin(minVal, nums[i]);
                maxVal = fmax(maxVal, nums[i]);
            }
        }
        count += right - left + 1;
    }

    return count;
}