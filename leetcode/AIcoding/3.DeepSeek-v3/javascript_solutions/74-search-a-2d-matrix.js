var searchMatrix = function(matrix, target) {
    if (!matrix.length || !matrix[0].length) return false;
    let m = matrix.length, n = matrix[0].length;
    let left = 0, right = m * n - 1;
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let midVal = matrix[Math.floor(mid / n)][mid % n];
        if (midVal === target) return true;
        else if (midVal < target) left = mid + 1;
        else right = mid - 1;
    }
    return false;
};