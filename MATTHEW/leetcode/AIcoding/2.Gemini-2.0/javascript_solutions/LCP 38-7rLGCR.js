var countUnguarded = function(m, n, guards, walls) {
    const matrix = Array(m).fill(null).map(() => Array(n).fill(0));

    for (const [row, col] of walls) {
        matrix[row][col] = 1;
    }

    for (const [row, col] of guards) {
        matrix[row][col] = 2;
    }

    for (const [row, col] of guards) {
        // Up
        for (let i = row - 1; i >= 0; i--) {
            if (matrix[i][col] === 1 || matrix[i][col] === 2) {
                break;
            }
            matrix[i][col] = 3;
        }

        // Down
        for (let i = row + 1; i < m; i++) {
            if (matrix[i][col] === 1 || matrix[i][col] === 2) {
                break;
            }
            matrix[i][col] = 3;
        }

        // Left
        for (let j = col - 1; j >= 0; j--) {
            if (matrix[row][j] === 1 || matrix[row][j] === 2) {
                break;
            }
            matrix[row][j] = 3;
        }

        // Right
        for (let j = col + 1; j < n; j++) {
            if (matrix[row][j] === 1 || matrix[row][j] === 2) {
                break;
            }
            matrix[row][j] = 3;
        }
    }

    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === 0) {
                count++;
            }
        }
    }

    return count;
};