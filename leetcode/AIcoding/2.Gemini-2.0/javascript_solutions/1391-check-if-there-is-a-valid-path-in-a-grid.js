var hasValidPath = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const visited = Array(m).fill(null).map(() => Array(n).fill(false));

    const directions = {
        1: [[0, 1], [0, -1]],
        2: [[1, 0], [-1, 0]],
        3: [[0, -1], [1, 0]],
        4: [[0, 1], [1, 0]],
        5: [[0, -1], [-1, 0]],
        6: [[0, 1], [-1, 0]]
    };

    function isValid(row, col) {
        return row >= 0 && row < m && col >= 0 && col < n;
    }

    function dfs(row, col) {
        if (row === m - 1 && col === n - 1) {
            return true;
        }

        visited[row][col] = true;

        const streetType = grid[row][col];
        const possibleDirections = directions[streetType];

        for (const [dr, dc] of possibleDirections) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (isValid(newRow, newCol) && !visited[newRow][newCol]) {
                const nextStreetType = grid[newRow][newCol];
                const nextPossibleDirections = directions[nextStreetType];

                let canConnect = false;
                for (const [ndr, ndc] of nextPossibleDirections) {
                    if (newRow + ndr === row && newCol + ndc === col) {
                        canConnect = true;
                        break;
                    }
                }

                if (canConnect && dfs(newRow, newCol)) {
                    return true;
                }
            }
        }

        return false;
    }

    return dfs(0, 0);
};