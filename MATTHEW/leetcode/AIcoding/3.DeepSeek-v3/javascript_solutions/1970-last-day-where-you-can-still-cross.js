var latestDayToCross = function(row, col, cells) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let left = 0, right = cells.length - 1;
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const grid = new Array(row).fill().map(() => new Array(col).fill(0));
        for (let i = 0; i <= mid; i++) {
            const [r, c] = cells[i];
            grid[r - 1][c - 1] = 1;
        }

        const queue = [];
        for (let i = 0; i < col; i++) {
            if (grid[0][i] === 0) {
                queue.push([0, i]);
                grid[0][i] = 1;
            }
        }

        let canCross = false;
        while (queue.length > 0) {
            const [r, c] = queue.shift();
            if (r === row - 1) {
                canCross = true;
                break;
            }
            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;
                if (nr >= 0 && nr < row && nc >= 0 && nc < col && grid[nr][nc] === 0) {
                    grid[nr][nc] = 1;
                    queue.push([nr, nc]);
                }
            }
        }

        if (canCross) {
            result = mid + 1;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};