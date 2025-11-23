var countRoutes = function(obstacleGrid, startRow, startCol, maxMove) {
    const m = obstacleGrid.length;
    const n = obstacleGrid[0].length;
    const MOD = 1000000007;
    let dp = Array(m).fill(null).map(() => Array(n).fill(null).map(() => Array(maxMove + 1).fill(0)));

    function solve(row, col, moves) {
        if (row < 0 || row >= m || col < 0 || col >= n || obstacleGrid[row][col] === 1) {
            return 0;
        }

        if (moves < 0) {
            return 0;
        }

        if (dp[row][col][moves] !== 0) {
            return dp[row][col][moves];
        }

        if (row === 0 && col === 0 && moves >= 0) {
            dp[row][col][moves] = 1;
            return 1;
        }

        if(moves === 0){
            return 0;
        }

        let count = 0;
        count = (count + solve(row + 1, col, moves - 1)) % MOD;
        count = (count + solve(row - 1, col, moves - 1)) % MOD;
        count = (count + solve(row, col + 1, moves - 1)) % MOD;
        count = (count + solve(row, col - 1, moves - 1)) % MOD;

        dp[row][col][moves] = count;
        return count;
    }

    return solve(startRow, startCol, maxMove);
};