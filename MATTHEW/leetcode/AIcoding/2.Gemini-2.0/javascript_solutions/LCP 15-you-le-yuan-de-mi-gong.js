var hasPath = function(maze, start, destination) {
    const m = maze.length;
    const n = maze[0].length;
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    function isValid(row, col) {
        return row >= 0 && row < m && col >= 0 && col < n;
    }

    function roll(row, col, dir) {
        let newRow = row;
        let newCol = col;
        while (isValid(newRow + dir[0], newCol + dir[1]) && maze[newRow + dir[0]][newCol + dir[1]] === 0) {
            newRow += dir[0];
            newCol += dir[1];
        }
        return [newRow, newCol];
    }

    function dfs(row, col) {
        if (visited[row][col]) {
            return false;
        }
        if (row === destination[0] && col === destination[1]) {
            return true;
        }

        visited[row][col] = true;

        for (const dir of directions) {
            const [newRow, newCol] = roll(row, col, dir);
            if (!visited[newRow][newCol]) {
                if (dfs(newRow, newCol)) {
                    return true;
                }
            }
        }
        return false;
    }

    return dfs(start[0], start[1]);
};