var magicalBoard = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const visited = new Array(m).fill().map(() => new Array(n).fill(false));
    let result = 0;

    function dfs(i, j, sum) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j]) {
            return;
        }
        sum += grid[i][j];
        if (i === m - 1 && j === n - 1) {
            if (sum % 5 === 0) {
                result++;
            }
            return;
        }
        visited[i][j] = true;
        for (const [dx, dy] of directions) {
            dfs(i + dx, j + dy, sum);
        }
        visited[i][j] = false;
    }

    dfs(0, 0, 0);
    return result;
};