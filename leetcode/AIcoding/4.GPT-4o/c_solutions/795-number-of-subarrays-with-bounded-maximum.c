int numSubarrayBoundedMax(int* nums, int numsSize, int left, int right) {
    int count = 0, start = 0, end = 0, validCount = 0;

    while (end < numsSize) {
        if (nums[end] > right) {
            validCount = 0;
            start = end + 1;
        } else {
            validCount = end - start + 1;
            if (nums[end] >= left) {
                count += validCount;
            }
        }
        end++;
    }

    return count;
}