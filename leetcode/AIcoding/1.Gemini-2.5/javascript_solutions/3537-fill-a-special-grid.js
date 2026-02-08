var fillSpecialGrid = function(n) {
    if (n <= 0) {
        return [];
    }

    const grid = Array(n).fill(0).map(() => Array(n).fill(0));

    let top = 0;
    let bottom = n - 1;
    let left = 0;
    let right = n - 1;
    let currentNumber = 1;

    while (top <= bottom && left <= right) {
        // Fill top row
        for (let j = left; j <= right; j++) {
            grid[top][j] = currentNumber++;
        }
        top++;

        // Fill right column
        for (let i = top; i <= bottom; i++) {
            grid[i][right] = currentNumber++;
        }
        right--;

        // Fill bottom row
        if (top <= bottom) {
            for (let j = right; j >= left; j--) {
                grid[bottom][j] = currentNumber++;
            }
            bottom--;
        }

        // Fill left column
        if (left <= right) {
            for (let i = bottom; i >= top; i--) {
                grid[i][left] = currentNumber++;
            }
            left++;
        }
    }

    return grid;
};