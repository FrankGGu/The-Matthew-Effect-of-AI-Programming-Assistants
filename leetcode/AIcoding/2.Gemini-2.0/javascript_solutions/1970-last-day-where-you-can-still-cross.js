var latestDayToCross = function(row, col, cells) {
    let left = 0;
    let right = cells.length;
    let ans = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (canCross(row, col, cells, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;

    function canCross(row, col, cells, day) {
        const grid = Array(row).fill(null).map(() => Array(col).fill(0));
        for (let i = 0; i < day; i++) {
            grid[cells[i][0] - 1][cells[i][1] - 1] = 1;
        }

        const visited = Array(row).fill(null).map(() => Array(col).fill(false));

        function dfs(r, c) {
            if (r < 0 || r >= row || c < 0 || c >= col || grid[r][c] === 1 || visited[r][c]) {
                return false;
            }

            visited[r][c] = true;

            if (r === row - 1) {
                return true;
            }

            return dfs(r + 1, c) || dfs(r - 1, c) || dfs(r, c + 1) || dfs(r, c - 1);
        }

        for (let c = 0; c < col; c++) {
            if (grid[0][c] === 0 && !visited[0][c] && dfs(0, c)) {
                return true;
            }
        }

        return false;
    }
};