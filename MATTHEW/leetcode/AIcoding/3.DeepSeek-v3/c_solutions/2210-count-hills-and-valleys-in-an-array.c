int countHillValley(int* nums, int numsSize) {
    int count = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        if (nums[i] == nums[i-1]) continue;

        int left = i - 1;
        while (left >= 0 && nums[left] == nums[i]) {
            left--;
        }
        if (left < 0) continue;

        int right = i + 1;
        while (right < numsSize && nums[right] == nums[i]) {
            right++;
        }
        if (right >= numsSize) continue;

        if ((nums[i] > nums[left] && nums[i] > nums[right]) || 
            (nums[i] < nums[left] && nums[i] < nums[right])) {
            count++;
        }
    }
    return count;
}