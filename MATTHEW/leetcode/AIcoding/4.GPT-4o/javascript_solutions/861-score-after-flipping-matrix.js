var matrixScore = function(A) {
    const m = A.length;
    const n = A[0].length;

    // Flip rows if the first column is 0
    for (let i = 0; i < m; i++) {
        if (A[i][0] === 0) {
            for (let j = 0; j < n; j++) {
                A[i][j] ^= 1;
            }
        }
    }

    let score = 0;

    // Calculate the score column by column
    for (let j = 0; j < n; j++) {
        let count = 0;
        for (let i = 0; i < m; i++) {
            count += A[i][j];
        }
        score += Math.max(count, m - count) * Math.pow(2, n - 1 - j);
    }

    return score;
};