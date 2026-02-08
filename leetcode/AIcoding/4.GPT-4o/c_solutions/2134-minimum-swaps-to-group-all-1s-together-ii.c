int minSwaps(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) count++;
    }

    if (count == 0) return 0;

    int maxOnesInWindow = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) maxOnesInWindow++;
        if (i >= count) {
            maxOnesInWindow -= nums[i - count];
        }
        if (i >= count - 1) {
            maxOnesInWindow = maxOnesInWindow > nums[i] ? maxOnesInWindow : maxOnesInWindow;
        }
    }

    return count - maxOnesInWindow;
}