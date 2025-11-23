var maxSumDivisibleByThree = function(nums) {
    let dp = [0, -Infinity, -Infinity];
    for (let num of nums) {
        let newDp = [...dp];
        let rem = num % 3;
        newDp[(0 + rem) % 3] = Math.max(newDp[(0 + rem) % 3], dp[0] + num);
        newDp[(1 + rem) % 3] = Math.max(newDp[(1 + rem) % 3], dp[1] + num);
        newDp[(2 + rem) % 3] = Math.max(newDp[(2 + rem) % 3], dp[2] + num);
        dp = newDp;
    }
    return dp[0];
};