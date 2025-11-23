var kthSmallest = function(matrix, k) {
    let left = matrix[0][0], right = matrix[matrix.length - 1][matrix[0].length - 1];

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let count = 0, row = matrix.length - 1, col = 0;

        while (row >= 0 && col < matrix[0].length) {
            if (matrix[row][col] <= mid) {
                count += row + 1;
                col++;
            } else {
                row--;
            }
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};