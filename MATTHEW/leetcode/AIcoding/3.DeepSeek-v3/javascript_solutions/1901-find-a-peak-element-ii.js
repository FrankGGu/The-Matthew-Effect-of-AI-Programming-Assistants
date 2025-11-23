var findPeakGrid = function(mat) {
    let left = 0, right = mat.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const maxInRow = Math.max(...mat[mid]);
        const maxIndex = mat[mid].indexOf(maxInRow);

        if (mid < mat.length - 1 && mat[mid][maxIndex] < mat[mid + 1][maxIndex]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    const maxInRow = Math.max(...mat[left]);
    const maxIndex = mat[left].indexOf(maxInRow);
    return [left, maxIndex];
};