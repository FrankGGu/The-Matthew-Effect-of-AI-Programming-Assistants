var oddCells = function(m, n, indices) {
    const matrix = Array(m).fill(null).map(() => Array(n).fill(0));

    for (const [row, col] of indices) {
        for (let j = 0; j < n; j++) {
            matrix[row][j]++;
        }
        for (let i = 0; i < m; i++) {
            matrix[i][col]++;
        }
    }

    let oddCount = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] % 2 !== 0) {
                oddCount++;
            }
        }
    }

    return oddCount;
};