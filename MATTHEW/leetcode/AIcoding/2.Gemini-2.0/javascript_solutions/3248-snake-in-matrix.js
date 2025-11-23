var snakeInMatrix = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const result = [];
    let row = 0;
    let col = 0;
    let direction = 1; // 1 for right, -1 for left

    while (row < m) {
        if (direction === 1) {
            for (let i = 0; i < n; i++) {
                result.push(matrix[row][i]);
            }
        } else {
            for (let i = n - 1; i >= 0; i--) {
                result.push(matrix[row][i]);
            }
        }
        row++;
        direction *= -1;
    }

    return result;
};