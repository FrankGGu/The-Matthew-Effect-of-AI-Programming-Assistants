function buildMatrix(k, m, n) {
    const matrix = Array.from({ length: m }, () => Array(n).fill(0));
    let num = 1;
    let left = 0, right = n - 1, top = 0, bottom = m - 1;

    while (num <= m * n) {
        for (let i = left; i <= right && num <= m * n; i++) {
            matrix[top][i] = num++;
        }
        top++;
        for (let i = top; i <= bottom && num <= m * n; i++) {
            matrix[i][right] = num++;
        }
        right--;
        for (let i = right; i >= left && num <= m * n; i--) {
            matrix[bottom][i] = num++;
        }
        bottom--;
        for (let i = bottom; i >= top && num <= m * n; i--) {
            matrix[i][left] = num++;
        }
        left++;
    }

    return matrix;
}