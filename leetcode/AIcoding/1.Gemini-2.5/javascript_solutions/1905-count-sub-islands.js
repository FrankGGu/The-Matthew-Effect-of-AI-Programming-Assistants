var countSubIslands = function(grid1, grid2) {
    const rows = grid1.length;
    const cols = grid1[0].length;
    let subIslandCount = 0;

    function dfs(r, c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid2[r][c] === 0) {
            return true;
        }

        let currentCellIsSub = (grid1[r][c] === 1);

        grid2[r][c] = 0;

        let neighbor1 = dfs(r + 1, c);
        let neighbor2 = dfs(r - 1, c);
        let neighbor3 = dfs(r, c + 1);
        let neighbor4 = dfs(r, c - 1);

        return currentCellIsSub && neighbor1 && neighbor2 && neighbor3 && neighbor4;
    }

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid2[r][c] === 1) {
                if (dfs(r, c)) {
                    subIslandCount++;
                }
            }
        }
    }

    return subIslandCount;
};