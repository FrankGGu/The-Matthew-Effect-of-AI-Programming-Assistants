function canSplitArray(nums, m) {
    if (nums.length < 2) return true;
    let count = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] + nums[i - 1] >= m) {
            count++;
        }
    }
    return count >= nums.length - 1;
}