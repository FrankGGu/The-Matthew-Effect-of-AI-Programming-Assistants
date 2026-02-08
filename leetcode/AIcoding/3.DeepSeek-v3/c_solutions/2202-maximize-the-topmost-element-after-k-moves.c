int maximumTop(int* nums, int numsSize, int k) {
    if (numsSize == 1 && k % 2 == 1) return -1;

    int max = -1;
    for (int i = 0; i < numsSize && i <= k; i++) {
        if (i == k - 1) continue;
        if (nums[i] > max) max = nums[i];
    }
    return max;
}