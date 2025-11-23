var longestPalindromeSubseq = function(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        dp[i][i] = 1;
        for (let j = i + 1; j < n; j++) {
            if (s[i] === s[j]) {
                dp[i][j] = dp[i + 1][j - 1] + 2;
            } else {
                dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    let maxLen = 0;
    const memo = new Map();

    const dfs = (i, j, ops) => {
        if (i >= j) {
            return i === j ? 1 : 0;
        }
        const key = `${i},${j},${ops}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let res;
        if (s[i] === s[j]) {
            res = 2 + dfs(i + 1, j - 1, ops);
        } else {
            if (ops > 0) {
                res = 2 + dfs(i + 1, j - 1, ops - 1);
            } else {
                res = Math.max(dfs(i + 1, j, ops), dfs(i, j - 1, ops));
            }
        }

        memo.set(key, res);
        return res;
    };

    maxLen = dfs(0, n - 1, k);
    return maxLen;
};