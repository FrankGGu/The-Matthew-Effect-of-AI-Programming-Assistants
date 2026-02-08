var findFarmland = function(land) {
    const rows = land.length;
    const cols = land[0].length;
    const result = [];

    const dfs = (r, c) => {
        let endRow = r;
        let endCol = c;
        while (endRow + 1 < rows && land[endRow + 1][c] === 1) {
            endRow++;
        }
        while (endCol + 1 < cols && land[r][endCol + 1] === 1) {
            endCol++;
        }
        for (let i = r; i <= endRow; i++) {
            for (let j = c; j <= endCol; j++) {
                land[i][j] = 0;
            }
        }
        result.push([r, c, endRow, endCol]);
    };

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (land[i][j] === 1) {
                dfs(i, j);
            }
        }
    }

    return result;
};