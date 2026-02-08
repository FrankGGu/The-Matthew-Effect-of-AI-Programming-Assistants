int countMonotonicPairs(int* nums, int numsSize) {
    long long count = 0;
    long long total = 0;
    int left = 0, right = 0;

    while (right < numsSize) {
        if (right == 0 || nums[right] >= nums[right - 1]) {
            total += (right - left + 1);
            right++;
        } else {
            left = right;
        }
    }

    left = 0;
    right = 0;

    while (right < numsSize) {
        if (right == 0 || nums[right] <= nums[right - 1]) {
            total += (right - left + 1);
            right++;
        } else {
            left = right;
        }
    }

    return (int)(total - numsSize);
}