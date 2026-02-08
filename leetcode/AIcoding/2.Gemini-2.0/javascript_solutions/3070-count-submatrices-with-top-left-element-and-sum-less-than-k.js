var countSubmatrices = function(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;
    let count = 0;

    for (let row = 0; row < m; row++) {
        for (let col = 0; col < n; col++) {
            let sum = 0;
            for (let i = row; i < m; i++) {
                for (let j = col; j < n; j++) {
                    sum += matrix[i][j];
                    if (sum <= k) {
                        count++;
                    } else {
                        break;
                    }
                }
                if (sum > k) {
                    break;
                }
                sum = 0;
                for (let r = row; r <= i; r++) {
                    for (let c = col; c < n; c++) {
                        sum += matrix[r][c];
                    }
                }
                if (sum > k) break;
            }
        }
    }

    return count;
};