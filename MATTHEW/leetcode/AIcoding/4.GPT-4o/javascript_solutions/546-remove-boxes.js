var removeBoxes = function(boxes) {
    const n = boxes.length;
    const dp = Array.from({ length: n }, () => Array.from({ length: n }, () => Array(n + 1).fill(0)));

    const dfs = (l, r, k) => {
        if (l > r) return 0;
        if (dp[l][r][k] !== 0) return dp[l][r][k];

        while (r > l && boxes[r] === boxes[r - 1]) {
            r--;
            k++;
        }

        dp[l][r][k] = dfs(l, r - 1, 0) + (k + 1) * (k + 1);
        for (let i = l; i < r; i++) {
            if (boxes[i] === boxes[r]) {
                dp[l][r][k] = Math.max(dp[l][r][k], dfs(l, i, k + 1) + dfs(i + 1, r - 1, 0));
            }
        }

        return dp[l][r][k];
    };

    return dfs(0, n - 1, 0);
};