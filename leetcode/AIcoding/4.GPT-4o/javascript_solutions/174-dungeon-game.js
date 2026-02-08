var calculateMinimumHP = function(dungeon) {
    let rows = dungeon.length;
    let cols = dungeon[0].length;
    let dp = Array.from({ length: rows + 1 }, () => Array(cols + 1).fill(Infinity));

    dp[rows][cols - 1] = 1;
    dp[rows - 1][cols] = 1;

    for (let i = rows - 1; i >= 0; i--) {
        for (let j = cols - 1; j >= 0; j--) {
            let minHpOnExit = Math.min(dp[i + 1][j], dp[i][j + 1]);
            dp[i][j] = Math.max(minHpOnExit - dungeon[i][j], 1);
        }
    }

    return dp[0][0];
};