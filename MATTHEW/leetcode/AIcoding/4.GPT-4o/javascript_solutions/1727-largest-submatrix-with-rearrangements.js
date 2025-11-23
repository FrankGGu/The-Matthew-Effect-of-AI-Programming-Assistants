var largestSubmatrix = function(matrix) {
    let m = matrix.length, n = matrix[0].length;
    let heights = Array(n).fill(0);
    let maxArea = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            heights[j] = matrix[i][j] === 0 ? 0 : heights[j] + 1;
        }
        let sortedHeights = [...heights].sort((a, b) => b - a);
        for (let j = 0; j < n; j++) {
            maxArea = Math.max(maxArea, sortedHeights[j] * (j + 1));
        }
    }

    return maxArea;
};