function countHillsAndValleys(nums) {
    let count = 0;
    for (let i = 1; i < nums.length - 1; i++) {
        if ((nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) || (nums[i] < nums[i - 1] && nums[i] < nums[i + 1])) {
            count++;
        }
    }
    return count;
}