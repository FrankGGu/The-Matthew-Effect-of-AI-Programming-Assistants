var minAreaRect = function(matrix) {
    if (!matrix || matrix.length === 0 || matrix[0].length === 0) {
        return 0;
    }

    let top = -1, left = -1, bottom = -1, right = -1;

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[0].length; j++) {
            if (matrix[i][j] === 1) {
                if (top === -1) {
                    top = i;
                }
                if (left === -1) {
                    left = j;
                }
                bottom = Math.max(bottom, i);
                right = Math.max(right, j);
            }
        }
    }

    if (top === -1) {
        return 0;
    }

    return (right - left + 1) * (bottom - top + 1);
};