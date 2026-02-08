var kthSmallest = function(matrix, k) {
    let n = matrix.length;
    let left = matrix[0][0];
    let right = matrix[n-1][n-1];

    while (left < right) {
        let mid = left + Math.floor((right - left) / 2);
        let count = 0;
        let j = n - 1;

        for (let i = 0; i < n; i++) {
            while (j >= 0 && matrix[i][j] > mid) {
                j--;
            }
            count += (j + 1);
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};