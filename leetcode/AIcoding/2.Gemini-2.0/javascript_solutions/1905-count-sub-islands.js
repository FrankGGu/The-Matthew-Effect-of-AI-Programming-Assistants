var countSubIslands = function(grid1, grid2) {
    let m = grid1.length;
    let n = grid1[0].length;
    let count = 0;

    const isValid = (row, col) => {
        return row >= 0 && row < m && col >= 0 && col < n;
    }

    const dfs = (row, col) => {
        if (!isValid(row, col) || grid2[row][col] === 0) {
            return true;
        }

        grid2[row][col] = 0;

        let isSub = grid1[row][col] === 1;

        let up = dfs(row - 1, col);
        let down = dfs(row + 1, col);
        let left = dfs(row, col - 1);
        let right = dfs(row, col + 1);

        return isSub && up && down && left && right;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid2[i][j] === 1) {
                if (dfs(i, j)) {
                    count++;
                }
            }
        }
    }

    return count;
};