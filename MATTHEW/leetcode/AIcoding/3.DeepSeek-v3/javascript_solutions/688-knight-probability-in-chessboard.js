var knightProbability = function(n, k, row, column) {
    const moves = [[-2, -1], [-1, -2], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1]];
    let dp = new Array(n).fill(0).map(() => new Array(n).fill(0).map(() => new Array(k + 1).fill(0));

    const dfs = (r, c, steps) => {
        if (r < 0 || r >= n || c < 0 || c >= n) return 0;
        if (steps === 0) return 1;
        if (dp[r][c][steps] !== 0) return dp[r][c][steps];

        let res = 0;
        for (const [dr, dc] of moves) {
            res += dfs(r + dr, c + dc, steps - 1) / 8;
        }
        dp[r][c][steps] = res;
        return res;
    };

    return dfs(row, column, k);
};