var smallestRangeII = function(nums, k) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let ans = nums[n - 1] - nums[0];
    for (let i = 0; i < n - 1; i++) {
        let a = nums[i];
        let b = nums[i + 1];
        let high = Math.max(nums[n - 1] - k, a + k);
        let low = Math.min(nums[0] + k, b - k);
        ans = Math.min(ans, high - low);
    }
    return ans;
};