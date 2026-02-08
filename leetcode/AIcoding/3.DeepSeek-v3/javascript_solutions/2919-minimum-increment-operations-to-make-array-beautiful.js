var minIncrementOperations = function(nums, k) {
    let dp0 = 0, dp1 = 0, dp2 = 0;
    for (let num of nums) {
        let newDp0 = Math.max(k - num, 0) + Math.min(dp0, dp1, dp2);
        let newDp1 = dp0;
        let newDp2 = dp1;
        dp0 = newDp0;
        dp1 = newDp1;
        dp2 = newDp2;
    }
    return Math.min(dp0, dp1, dp2);
};