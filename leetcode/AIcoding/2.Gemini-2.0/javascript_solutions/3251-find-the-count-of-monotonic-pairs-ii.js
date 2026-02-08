var countMonotonicPairs = function(nums) {
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (nums[i] <= nums[j]) {
                ans++;
            }
        }
    }
    return ans;
};