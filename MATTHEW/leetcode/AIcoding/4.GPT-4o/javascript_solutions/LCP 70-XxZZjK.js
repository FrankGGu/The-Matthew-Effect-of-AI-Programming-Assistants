function sandLandManagement(A) {
    const n = A.length;
    const m = A[0].length;
    let result = Array.from({ length: n }, () => Array(m).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            result[i][j] = A[i][j];
            if (i > 0) result[i][j] = Math.min(result[i][j], result[i - 1][j]);
            if (j > 0) result[i][j] = Math.min(result[i][j], result[i][j - 1]);
        }
    }

    for (let i = n - 1; i >= 0; i--) {
        for (let j = m - 1; j >= 0; j--) {
            if (i < n - 1) result[i][j] = Math.min(result[i][j], result[i + 1][j]);
            if (j < m - 1) result[i][j] = Math.min(result[i][j], result[i][j + 1]);
        }
    }

    let total = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            total += result[i][j] - A[i][j];
        }
    }

    return total;
}