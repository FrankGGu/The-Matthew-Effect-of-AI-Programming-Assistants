var findThePowerOfKSizeSubarrays = function(nums, k, power) {
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i <= n - k; i++) {
        let sum = 0;
        for (let j = i; j < i + k; j++) {
            sum += nums[j];
        }
        ans += Math.pow(sum, power);
    }
    return ans;
};