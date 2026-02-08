var minimizeArrayValue = function(nums) {
    let sum = 0;
    let ans = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        ans = Math.max(ans, Math.ceil(sum / (i + 1)));
    }
    return ans;
};