var sumOfVariableLengthSubarrays = function(nums, k) {
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        let sum = 0;
        for (let j = i; j < n; j++) {
            sum += nums[j];
            if (sum >= k) {
                ans++;
            }
        }
    }
    return ans;
};