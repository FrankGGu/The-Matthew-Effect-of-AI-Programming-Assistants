var minPushBox = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    let boxRow, boxCol, playerRow, playerCol, targetRow, targetCol;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 'B') {
                boxRow = i;
                boxCol = j;
            } else if (grid[i][j] === 'S') {
                playerRow = i;
                playerCol = j;
            } else if (grid[i][j] === 'T') {
                targetRow = i;
                targetCol = j;
            }
        }
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    function canReach(startRow, startCol, endRow, endCol, avoidRow, avoidCol) {
        const visited = new Array(m).fill(null).map(() => new Array(n).fill(false));
        const queue = [[startRow, startCol]];
        visited[startRow][startCol] = true;

        while (queue.length > 0) {
            const [row, col] = queue.shift();

            if (row === endRow && col === endCol) {
                return true;
            }

            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n &&
                    grid[newRow][newCol] !== '#' && !visited[newRow][newCol] &&
                    !(newRow === avoidRow && newCol === avoidCol)) {
                    visited[newRow][newCol] = true;
                    queue.push([newRow, newCol]);
                }
            }
        }

        return false;
    }

    const visited = new Array(m).fill(null).map(() => new Array(n).fill(null).map(() => new Array(m * n).fill(false)));
    const queue = [[boxRow, boxCol, playerRow * n + playerCol, 0]];
    visited[boxRow][boxCol][playerRow * n + playerCol] = true;

    while (queue.length > 0) {
        const [row, col, playerPos, moves] = queue.shift();
        const playerRow = Math.floor(playerPos / n);
        const playerCol = playerPos % n;

        if (row === targetRow && col === targetCol) {
            return moves;
        }

        for (const [dr, dc] of directions) {
            const newBoxRow = row + dr;
            const newBoxCol = col + dc;
            const newPlayerRow = row - dr;
            const newPlayerCol = col - dc;

            if (newBoxRow >= 0 && newBoxRow < m && newBoxCol >= 0 && newBoxCol < n &&
                grid[newBoxRow][newBoxCol] !== '#' &&
                canReach(playerRow, playerCol, newPlayerRow, newPlayerCol, row, col)) {
                if (!visited[newBoxRow][newBoxCol][row * n + col]) {
                    visited[newBoxRow][newBoxCol][row * n + col] = true;
                    queue.push([newBoxRow, newBoxCol, row * n + col, moves + 1]);
                }
            }
        }
    }

    return -1;
};