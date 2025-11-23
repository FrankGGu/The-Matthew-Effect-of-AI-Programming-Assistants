var searchMatrix = function(matrix, target) {
    if (!matrix.length || !matrix[0].length) return false;
    let rows = matrix.length, cols = matrix[0].length;
    let left = 0, right = rows * cols - 1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let midValue = matrix[Math.floor(mid / cols)][mid % cols];

        if (midValue === target) {
            return true;
        } else if (midValue < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return false;
};