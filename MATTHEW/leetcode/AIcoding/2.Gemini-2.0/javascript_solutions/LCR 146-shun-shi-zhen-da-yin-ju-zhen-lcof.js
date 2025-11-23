var spiralOrder = function(matrix) {
    const result = [];
    let top = 0;
    let bottom = matrix.length - 1;
    let left = 0;
    let right = matrix[0].length - 1;
    let dir = 0; // 0: right, 1: down, 2: left, 3: up

    while (top <= bottom && left <= right) {
        if (dir === 0) {
            for (let i = left; i <= right; i++) {
                result.push(matrix[top][i]);
            }
            top++;
        } else if (dir === 1) {
            for (let i = top; i <= bottom; i++) {
                result.push(matrix[i][right]);
            }
            right--;
        } else if (dir === 2) {
            for (let i = right; i >= left; i--) {
                result.push(matrix[bottom][i]);
            }
            bottom--;
        } else if (dir === 3) {
            for (let i = bottom; i >= top; i--) {
                result.push(matrix[i][left]);
            }
            left++;
        }
        dir = (dir + 1) % 4;
    }

    return result;
};