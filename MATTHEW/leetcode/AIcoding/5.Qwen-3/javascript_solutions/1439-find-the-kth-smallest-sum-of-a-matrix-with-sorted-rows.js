function kthSmallest(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;

    let left = matrix[0][0];
    let right = matrix[m - 1][n - 1];

    while (left < right) {
        const mid = left + Math.floor((right - left) / 2);
        const count = countLessEqual(matrix, mid);

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}

function countLessEqual(matrix, target) {
    const m = matrix.length;
    const n = matrix[0].length;
    let count = 0;
    let j = n - 1;

    for (let i = 0; i < m; i++) {
        while (j >= 0 && matrix[i][j] > target) {
            j--;
        }
        count += j + 1;
    }

    return count;
}