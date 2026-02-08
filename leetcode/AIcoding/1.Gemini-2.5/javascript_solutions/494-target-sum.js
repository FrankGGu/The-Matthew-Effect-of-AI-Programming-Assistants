var findTargetSumWays = function(nums, S) {
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }

    if ((S + sum) % 2 !== 0 || S + sum < 0) {
        return 0;
    }

    let targetSubsetSum = (S + sum) / 2;

    let dp = new Array(targetSubsetSum + 1).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let j = targetSubsetSum; j >= num; j--) {
            dp[j] += dp[j - num];
        }
    }

    return dp[targetSubsetSum];
};