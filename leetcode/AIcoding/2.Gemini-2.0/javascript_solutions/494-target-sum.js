var findTargetSumWays = function(nums, target) {
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }
    if ((sum + target) % 2 !== 0) {
        return 0;
    }
    let newTarget = (sum + target) / 2;
    if (newTarget < 0) {
        return 0;
    }

    let dp = new Array(newTarget + 1).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let i = newTarget; i >= num; i--) {
            dp[i] += dp[i - num];
        }
    }

    return dp[newTarget];
};