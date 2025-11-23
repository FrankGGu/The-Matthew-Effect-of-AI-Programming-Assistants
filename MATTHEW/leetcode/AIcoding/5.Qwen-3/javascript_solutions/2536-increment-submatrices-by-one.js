function rangeAddQueries(n, queries) {
    const matrix = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (const [r1, c1, r2, c2] of queries) {
        for (let i = r1; i <= r2; i++) {
            matrix[i][c1]++;
            if (c2 + 1 < n) matrix[i][c2 + 1]--;
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 1; j < n; j++) {
            matrix[i][j] += matrix[i][j - 1];
        }
    }

    return matrix;
}