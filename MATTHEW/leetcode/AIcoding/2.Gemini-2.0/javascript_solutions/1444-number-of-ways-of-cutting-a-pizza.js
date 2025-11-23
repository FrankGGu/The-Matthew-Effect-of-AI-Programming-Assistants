var ways = function(pizza, k) {
    const m = pizza.length;
    const n = pizza[0].length;
    const mod = 10**9 + 7;

    const apples = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));
    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            apples[i][j] = apples[i + 1][j] + apples[i][j + 1] - apples[i + 1][j + 1] + (pizza[i][j] === 'A' ? 1 : 0);
        }
    }

    const dp = Array(k).fill(null).map(() => Array(m).fill(null).map(() => Array(n).fill(-1)));

    function solve(rem, row, col) {
        if (apples[row][col] === 0) return 0;
        if (rem === 1) return 1;
        if (dp[rem - 1][row][col] !== -1) return dp[rem - 1][row][col];

        let ans = 0;

        for (let i = row + 1; i < m; i++) {
            if (apples[row][col] - apples[i][col] > 0) {
                ans = (ans + solve(rem - 1, i, col)) % mod;
            }
        }

        for (let j = col + 1; j < n; j++) {
            if (apples[row][col] - apples[row][j] > 0) {
                ans = (ans + solve(rem - 1, row, j)) % mod;
            }
        }

        return dp[rem - 1][row][col] = ans;
    }

    return solve(k, 0, 0);
};