var sumOfPowers = function(nums, k) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const MOD = 1e9 + 7;
    let dp = new Array(n + 1).fill().map(() => new Array(k + 1).fill().map(() => new Map()));

    function dfs(index, count, minDiff) {
        if (count === k) {
            return minDiff;
        }
        if (index === n) {
            return 0;
        }
        const key = `${index},${count},${minDiff}`;
        if (dp[index][count].has(key)) {
            return dp[index][count].get(key);
        }

        let res = 0;
        // Option 1: not take nums[index]
        res += dfs(index + 1, count, minDiff);

        // Option 2: take nums[index]
        let newMinDiff = minDiff;
        if (count > 0) {
            const diff = nums[index] - nums[index - 1];
            if (newMinDiff === Infinity || diff < newMinDiff) {
                newMinDiff = diff;
            }
        }
        res += dfs(index + 1, count + 1, newMinDiff);

        res %= MOD;
        dp[index][count].set(key, res);
        return res;
    }

    return dfs(0, 0, Infinity);
};