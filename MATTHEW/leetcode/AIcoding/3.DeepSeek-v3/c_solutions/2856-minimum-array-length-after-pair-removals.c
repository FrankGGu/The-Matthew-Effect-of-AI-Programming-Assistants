int minLengthAfterRemovals(int* nums, int numsSize) {
    int left = 0, right = (numsSize + 1) / 2;
    int count = numsSize;

    while (right < numsSize && left < (numsSize + 1) / 2) {
        if (nums[left] < nums[right]) {
            count -= 2;
            left++;
            right++;
        } else {
            right++;
        }
    }

    return count;
}