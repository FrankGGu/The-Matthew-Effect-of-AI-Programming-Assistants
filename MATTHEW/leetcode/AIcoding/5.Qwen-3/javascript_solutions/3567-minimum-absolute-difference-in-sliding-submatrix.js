function minAbsoluteDifference(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;
    const result = [];

    for (let i = 0; i <= m - k; i++) {
        const row = [];
        for (let j = 0; j <= n - k; j++) {
            const submatrix = [];
            for (let x = 0; x < k; x++) {
                for (let y = 0; y < k; y++) {
                    submatrix.push(matrix[i + x][j + y]);
                }
            }
            submatrix.sort((a, b) => a - b);
            let minDiff = Infinity;
            for (let z = 1; z < submatrix.length; z++) {
                minDiff = Math.min(minDiff, submatrix[z] - submatrix[z - 1]);
            }
            row.push(minDiff);
        }
        result.push(row);
    }

    return result;
}