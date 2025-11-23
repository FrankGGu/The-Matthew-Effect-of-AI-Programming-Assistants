var hasValidPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    if ((m + n - 1) % 2 !== 0) return false;

    const memo = new Array(m).fill(null).map(() => new Array(n).fill(null).map(() => new Array(m + n).fill(undefined)));

    function dfs(row, col, balance) {
        if (row < 0 || row >= m || col < 0 || col >= n) return false;
        balance += (grid[row][col] === '(' ? 1 : -1);

        if (balance < 0) return false;

        if (memo[row][col][balance] !== undefined) return memo[row][col][balance];

        if (row === m - 1 && col === n - 1) {
            memo[row][col][balance] = balance === 0;
            return balance === 0;
        }

        memo[row][col][balance] = dfs(row + 1, col, balance) || dfs(row, col + 1, balance);
        return memo[row][col][balance];
    }

    if (grid[0][0] === ')') return false;
    return dfs(0, 0, 0);
};