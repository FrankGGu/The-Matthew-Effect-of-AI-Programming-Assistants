var findTargetSumWays = function(nums, target) {
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }

    // We are looking for sum(P) - sum(N) = target
    // We also know sum(P) + sum(N) = sum
    // Adding these two equations: 2 * sum(P) = target + sum
    // So, sum(P) = (target + sum) / 2
    // This transforms the problem into finding the number of subsets
    // that sum up to (target + sum) / 2.

    if ((target + sum) % 2 !== 0 || target + sum < 0) {
        return 0;
    }

    const s = (target + sum) / 2;

    // dp[i] will store the number of ways to achieve sum i
    const dp = new Array(s + 1).fill(0);
    dp[0] = 1; // There's one way to achieve sum 0 (by choosing an empty set)

    for (let num of nums) {
        for (let j = s; j >= num; j--) {
            dp[j] += dp[j - num];
        }
    }

    return dp[s];
};