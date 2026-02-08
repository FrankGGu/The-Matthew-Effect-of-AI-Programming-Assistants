var canPartition = function(nums) {
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }

    if (totalSum % 2 !== 0) {
        return false;
    }

    const targetSum = totalSum / 2;
    const dp = new Array(targetSum + 1).fill(false);
    dp[0] = true;

    for (let num of nums) {
        for (let j = targetSum; j >= num; j--) {
            dp[j] = dp[j] || dp[j - num];
        }
    }

    return dp[targetSum];
};