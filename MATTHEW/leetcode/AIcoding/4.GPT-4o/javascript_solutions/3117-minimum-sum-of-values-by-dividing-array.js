function minimizeArrayValue(nums) {
    let max = Math.max(...nums);
    let total = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        total += nums[i];
        max = Math.max(max, Math.ceil(total / (i + 1)));
    }

    return max;
}