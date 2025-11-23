var tilingRectangle = function(n, m) {
    if (n === m) return 1;
    let dp = new Array(n + 1).fill(null).map(() => new Array(m + 1).fill(Infinity));

    function solve(height, width) {
        if (height === width) return 1;
        if (height === 0 || width === 0) return 0;
        if (dp[height][width] !== Infinity) return dp[height][width];

        let ans = Infinity;

        for (let i = 1; i <= Math.min(height, width); i++) {
            ans = Math.min(ans, 1 + solve(height - i, width) + solve(i, width - i));
            ans = Math.min(ans, 1 + solve(height, width - i) + solve(height - i, i));
        }

        return dp[height][width] = ans;
    }

    if (n > m) {
        [n, m] = [m, n];
    }
    return solve(n, m);
};