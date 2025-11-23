var isPossibleToCutPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    if (m === 1 && n === 1) return false;

    function dfs(row, col, visited) {
        if (row < 0 || row >= m || col < 0 || col >= n || grid[row][col] === 0 || visited[row][col]) {
            return false;
        }

        if (row === m - 1 && col === n - 1) {
            return true;
        }

        visited[row][col] = true;

        return dfs(row + 1, col, visited) || dfs(row, col + 1, visited);
    }

    let visited1 = Array(m).fill(null).map(() => Array(n).fill(false));
    if (!dfs(0, 0, visited1)) return true;

    let pathRow = -1;
    let pathCol = -1;

    function findPath(row, col, visited) {
        if (row < 0 || row >= m || col < 0 || col >= n || grid[row][col] === 0 || visited[row][col]) {
            return false;
        }

        visited[row][col] = true;

        if (row === m - 1 && col === n - 1) {
            pathRow = row;
            pathCol = col;
            return true;
        }

        if (findPath(row + 1, col, visited)) return true;
        if (findPath(row, col + 1, visited)) return true;

        return false;
    }

    let visited2 = Array(m).fill(null).map(() => Array(n).fill(false));
    findPath(0, 0, visited2);

    grid[pathRow][pathCol] = 0;

    let visited3 = Array(m).fill(null).map(() => Array(n).fill(false));
    if (!dfs(0, 0, visited3)) return true;

    grid[pathRow][pathCol] = 1;
    return false;
};