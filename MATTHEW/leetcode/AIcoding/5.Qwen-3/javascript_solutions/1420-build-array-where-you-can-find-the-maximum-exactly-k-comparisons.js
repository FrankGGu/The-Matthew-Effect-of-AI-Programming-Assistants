function dp(n, k, maxSum, memo) {
    if (n === 0) return 0;
    if (k === 0) return 1;
    if (memo[n][k] !== -1) return memo[n][k];

    let res = 0;
    for (let i = 1; i <= maxSum; i++) {
        res += dp(n - 1, k - 1, i, memo);
    }

    memo[n][k] = res;
    return res;
}

function maxValue(n, k, maxSum, memo) {
    if (n === 0) return 0;
    if (k === 0) return 1;
    if (memo[n][k] !== -1) return memo[n][k];

    let res = 0;
    for (let i = 1; i <= maxSum; i++) {
        res += maxValue(n - 1, k, i, memo);
    }

    memo[n][k] = res;
    return res;
}

function numberOfArrays(n, k, maxSum) {
    const MOD = 10 ** 9 + 7;
    const memo1 = Array.from({ length: n + 1 }, () => Array(k + 1).fill(-1));
    const memo2 = Array.from({ length: n + 1 }, () => Array(k + 1).fill(-1));

    function solve(n, k, maxSum, isMax) {
        if (n === 0) return 0;
        if (k === 0) return 1;
        if (isMax) {
            if (memo2[n][k] !== -1) return memo2[n][k];
            let res = 0;
            for (let i = 1; i <= maxSum; i++) {
                res += solve(n - 1, k, i, false);
            }
            memo2[n][k] = res % MOD;
            return memo2[n][k];
        } else {
            if (memo1[n][k] !== -1) return memo1[n][k];
            let res = 0;
            for (let i = 1; i <= maxSum; i++) {
                res += solve(n - 1, k - 1, i, true);
            }
            memo1[n][k] = res % MOD;
            return memo1[n][k];
        }
    }

    return solve(n, k, maxSum, false);
}