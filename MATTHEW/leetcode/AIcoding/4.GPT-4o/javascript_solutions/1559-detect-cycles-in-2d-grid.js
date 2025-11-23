var containsCycle = function(grid) {
    const rows = grid.length, cols = grid[0].length;
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));

    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const dfs = (r, c, parentR, parentC, char) => {
        if (visited[r][c]) return true;
        visited[r][c] = true;

        for (const [dr, dc] of directions) {
            const newR = r + dr, newC = c + dc;
            if (newR >= 0 && newR < rows && newC >= 0 && newC < cols && (newR !== parentR || newC !== parentC)) {
                if (grid[newR][newC] === char && dfs(newR, newC, r, c, char)) {
                    return true;
                }
            }
        }

        return false;
    };

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (!visited[r][c]) {
                if (dfs(r, c, -1, -1, grid[r][c])) {
                    return true;
                }
            }
        }
    }

    return false;
};