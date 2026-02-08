var spiralOrder = function(matrix) {
    const result = [];
    let top = 0, bottom = matrix.length - 1;
    let left = 0, right = matrix[0].length - 1;

    while (top <= bottom && left <= right) {
        for (let i = left; i <= right; i++) {
            result.push(matrix[top][i]);
        }
        top++;

        if (top > bottom) break;

        for (let i = top; i <= bottom; i++) {
            result.push(matrix[i][right]);
        }
        right--;

        if (left > right) break;

        for (let i = right; i >= left; i--) {
            result.push(matrix[bottom][i]);
        }
        bottom--;

        if (top > bottom) break;

        for (let i = bottom; i >= top; i--) {
            result.push(matrix[i][left]);
        }
        left++;
    }

    return result;
};