int maximizeWin(int* nums, int numsSize, int k) {
    int left = 0, maxWin = 0;
    for (int right = 0; right < numsSize; right++) {
        while (nums[right] - nums[left] > k) {
            left++;
        }
        maxWin = fmax(maxWin, right - left + 1);
    }
    return maxWin;
}