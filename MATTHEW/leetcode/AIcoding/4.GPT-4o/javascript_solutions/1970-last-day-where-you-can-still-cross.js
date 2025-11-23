var latestDayToCross = function(row, col, cells) {
    const isValid = (r, c) => r >= 0 && r < row && c >= 0 && c < col;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const canCross = (day) => {
        const grid = Array.from({ length: row }, () => Array(col).fill(0));
        const water = new Set();

        for (let i = 0; i < day; i++) {
            water.add(`${cells[i][0]}-${cells[i][1]}`);
        }

        const queue = [];
        for (let c = 0; c < col; c++) {
            if (!water.has(`0-${c + 1}`)) {
                queue.push([0, c]);
                grid[0][c] = 1;
            }
        }

        while (queue.length) {
            const [r, c] = queue.shift();
            if (r === row - 1) return true;
            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;
                if (isValid(nr, nc) && !water.has(`${nr}-${nc + 1}`) && !grid[nr][nc]) {
                    grid[nr][nc] = 1;
                    queue.push([nr, nc]);
                }
            }
        }
        return false;
    };

    let left = 1, right = cells.length, answer = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canCross(mid)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
};