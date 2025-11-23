var numEnclaves = function(A) {
    const rows = A.length;
    const cols = A[0].length;

    const dfs = (r, c) => {
        if (r < 0 || r >= rows || c < 0 || c >= cols || A[r][c] === 0) return;
        A[r][c] = 0;
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    };

    for (let i = 0; i < rows; i++) {
        if (A[i][0] === 1) dfs(i, 0);
        if (A[i][cols - 1] === 1) dfs(i, cols - 1);
    }

    for (let j = 0; j < cols; j++) {
        if (A[0][j] === 1) dfs(0, j);
        if (A[rows - 1][j] === 1) dfs(rows - 1, j);
    }

    let count = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (A[i][j] === 1) count++;
        }
    }

    return count;
};