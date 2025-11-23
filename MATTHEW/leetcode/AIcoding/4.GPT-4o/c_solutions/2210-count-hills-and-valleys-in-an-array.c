int countHillsAndValleys(int* nums, int numsSize) {
    if (numsSize < 3) return 0;
    int count = 0;
    for (int i = 1; i < numsSize - 1; i++) {
        if ((nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) || (nums[i] < nums[i - 1] && nums[i] < nums[i + 1])) ) {
            count++;
            i++;
        }
    }
    return count;
}