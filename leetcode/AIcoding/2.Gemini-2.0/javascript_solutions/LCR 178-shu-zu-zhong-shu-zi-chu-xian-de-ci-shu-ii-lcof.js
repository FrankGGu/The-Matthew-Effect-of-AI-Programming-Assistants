var minNumberOperations = function(nums) {
    let ans = 0;
    let prev = 0;
    for (let i = 0; i < nums.length; i++) {
        ans += Math.max(0, nums[i] - prev);
        prev = nums[i];
    }
    return ans;
};