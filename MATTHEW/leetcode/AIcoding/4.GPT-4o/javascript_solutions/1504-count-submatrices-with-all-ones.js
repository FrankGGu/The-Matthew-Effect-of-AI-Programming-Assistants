var numSubmat = function(mat) {
    const m = mat.length, n = mat[0].length;
    let count = 0;
    const heights = Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            heights[j] = mat[i][j] === 0 ? 0 : heights[j] + 1;
            let minHeight = heights[j];
            for (let k = j; k >= 0; k--) {
                if (heights[k] === 0) break;
                minHeight = Math.min(minHeight, heights[k]);
                count += minHeight;
            }
        }
    }

    return count;
};