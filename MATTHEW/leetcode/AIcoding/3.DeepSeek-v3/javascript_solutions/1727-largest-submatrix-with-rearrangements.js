var largestSubmatrix = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    let maxArea = 0;

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === 1) {
                matrix[i][j] += matrix[i - 1][j];
            }
        }
    }

    for (let i = 0; i < m; i++) {
        matrix[i].sort((a, b) => b - a);
        for (let j = 0; j < n; j++) {
            const height = matrix[i][j];
            const width = j + 1;
            maxArea = Math.max(maxArea, height * width);
        }
    }

    return maxArea;
};