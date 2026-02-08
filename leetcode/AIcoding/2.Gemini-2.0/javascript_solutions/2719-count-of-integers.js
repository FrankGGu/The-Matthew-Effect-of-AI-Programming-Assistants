var count = function(num1, num2, min_sum, max_sum) {
    const MOD = 10**9 + 7;

    const solve = (num, min_sum, max_sum) => {
        const n = num.length;
        const dp = Array(n + 1).fill(null).map(() => Array(Math.min(n * 9 + 1, max_sum + 1)).fill(-1));

        const dfs = (idx, sum, isLimit) => {
            if (sum > max_sum) return 0;
            if (idx === n) return sum >= min_sum ? 1 : 0;
            if (!isLimit && dp[idx][sum] !== -1) return dp[idx][sum];

            let up = isLimit ? parseInt(num[idx]) : 9;
            let res = 0;
            for (let i = 0; i <= up; i++) {
                res = (res + dfs(idx + 1, sum + i, isLimit && i === up)) % MOD;
            }

            if (!isLimit) dp[idx][sum] = res;
            return res;
        };

        return dfs(0, 0, true);
    };

    let ans = (solve(num2, min_sum, max_sum) - solve(num1, min_sum, max_sum) + MOD) % MOD;

    let sumNum1 = 0;
    for (let digit of num1) {
        sumNum1 += parseInt(digit);
    }

    if (sumNum1 >= min_sum && sumNum1 <= max_sum) {
        ans = (ans + 1) % MOD;
    }

    return ans;
};