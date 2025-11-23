function maximumTrailingZeros(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array.from({ length: n }, () => Array(4).fill(0)));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const num = parseInt(grid[i][j]);
            let zeros = 0;
            while (num % 10 === 0) {
                zeros++;
                num /= 10;
            }
            dp[i][j][0] = zeros; // up
            dp[i][j][1] = zeros; // left
            dp[i][j][2] = zeros; // down
            dp[i][j][3] = zeros; // right
        }
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            dp[i][j][0] += dp[i - 1][j][0];
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 1; j < n; j++) {
            dp[i][j][1] += dp[i][j - 1][1];
        }
    }

    for (let i = m - 2; i >= 0; i--) {
        for (let j = 0; j < n; j++) {
            dp[i][j][2] += dp[i + 1][j][2];
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = n - 2; j >= 0; j--) {
            dp[i][j][3] += dp[i][j + 1][3];
        }
    }

    let maxZeros = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const up = dp[i][j][0];
            const left = dp[i][j][1];
            const down = dp[i][j][2];
            const right = dp[i][j][3];

            const corner1 = up + left - dp[i][j][0]; // top-left
            const corner2 = up + right - dp[i][j][0]; // top-right
            const corner3 = down + left - dp[i][j][0]; // bottom-left
            const corner4 = down + right - dp[i][j][0]; // bottom-right

            maxZeros = Math.max(maxZeros, corner1, corner2, corner3, corner4);
        }
    }

    return maxZeros;
}