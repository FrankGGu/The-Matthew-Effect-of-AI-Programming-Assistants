var findPeakGrid = function(mat) {
    let m = mat.length;
    let n = mat[0].length;
    let low = 0;
    let high = m - 1;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let maxCol = 0;
        for (let j = 1; j < n; j++) {
            if (mat[mid][j] > mat[mid][maxCol]) {
                maxCol = j;
            }
        }

        if (mid > 0 && mat[mid][maxCol] < mat[mid - 1][maxCol]) {
            high = mid - 1;
        } else if (mid < m - 1 && mat[mid][maxCol] < mat[mid + 1][maxCol]) {
            low = mid + 1;
        } else {
            return [mid, maxCol];
        }
    }
};