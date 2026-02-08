var minimumReplacement = function(nums) {
    let n = nums.length;
    let ans = 0;
    let prev = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] > prev) {
            let k = Math.ceil(nums[i] / prev);
            ans += k - 1;
            prev = Math.floor(nums[i] / k);
        } else {
            prev = nums[i];
        }
    }
    return ans;
};