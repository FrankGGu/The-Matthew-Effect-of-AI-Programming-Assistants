var latestDayToCross = function(row, col, cells) {

    const canCross = (day) => {
        const grid = Array(row).fill(0).map(() => Array(col).fill(0));

        for (let i = 0; i < day; i++) {
            grid[cells[i][0] - 1][cells[i][1] - 1] = 1;
        }

        const queue = [];
        const visited = Array(row).fill(0).map(() => Array(col).fill(false));

        for (let c = 0; c < col; c++) {
            if (grid[0][c] === 0) {
                queue.push([0, c]);
                visited[0][c] = true;
            }
        }

        const dr = [-1, 1, 0, 0];
        const dc = [0, 0, -1, 1];

        let head = 0;
        while (head < queue.length) {
            const [r, c] = queue[head++];

            if (r === row - 1) {
                return true;
            }

            for (let i = 0; i < 4; i++) {
                const nr = r + dr[i];
                const nc = c + dc[i];

                if (nr >= 0 && nr < row && nc >= 0 && nc < col &&
                    grid[nr][nc] === 0 && !visited[nr][nc]) {

                    visited[nr][nc] = true;
                    queue.push([nr, nc]);
                }
            }
        }

        return false;
    };

    let low = 1;
    let high = cells.length;
    let ans = 0;

    while (low <= high) {
        const mid = Math.floor(low + (high - low) / 2);
        if (canCross(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};