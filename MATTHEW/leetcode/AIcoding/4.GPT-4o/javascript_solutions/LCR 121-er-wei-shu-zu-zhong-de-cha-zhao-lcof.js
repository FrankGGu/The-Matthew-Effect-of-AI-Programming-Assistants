function searchMatrix(matrix, target) {
    if (!matrix.length || !matrix[0].length) return false;
    let row = matrix.length, col = matrix[0].length;
    let left = 0, right = row * col - 1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const midValue = matrix[Math.floor(mid / col)][mid % col];
        if (midValue === target) {
            return true;
        } else if (midValue < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return false;
}