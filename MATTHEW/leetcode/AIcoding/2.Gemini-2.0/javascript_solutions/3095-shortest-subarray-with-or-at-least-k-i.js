var shortestSubarray = function(nums, k) {
    let n = nums.length;
    let ans = n + 1;
    for (let i = 0; i < n; i++) {
        let orVal = 0;
        for (let j = i; j < n; j++) {
            orVal |= nums[j];
            if (orVal >= k) {
                ans = Math.min(ans, j - i + 1);
                break;
            }
        }
    }
    return ans > n ? -1 : ans;
};