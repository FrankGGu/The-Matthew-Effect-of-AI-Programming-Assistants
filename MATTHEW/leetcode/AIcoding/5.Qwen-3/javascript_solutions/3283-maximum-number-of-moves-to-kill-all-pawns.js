function maxMoves(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [0, -1], [0, 1], [1, 0]];

    function dfs(i, j, visited) {
        let max = 0;
        for (const [dx, dy] of directions) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && !visited.has(`${x},${y}`) && grid[x][y] === 'p') {
                const newVisited = new Set(visited);
                newVisited.add(`${x},${y}`);
                max = Math.max(max, 1 + dfs(x, y, newVisited));
            }
        }
        return max;
    }

    let result = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 'k') {
                const visited = new Set();
                visited.add(`${i},${j}`);
                result = Math.max(result, dfs(i, j, visited));
            }
        }
    }
    return result;
}