var numSubmat = function(mat) {
    const rows = mat.length;
    const cols = mat[0].length;
    let totalSubmatrices = 0;

    const height = Array(rows).fill(0).map(() => Array(cols).fill(0));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (mat[i][j] === 1) {
                height[i][j] = (i > 0 ? height[i - 1][j] : 0) + 1;

                let minHeight = height[i][j];
                for (let k = j; k >= 0; k--) {
                    if (mat[i][k] === 0) {
                        break;
                    }
                    minHeight = Math.min(minHeight, height[i][k]);
                    totalSubmatrices += minHeight;
                }
            }
        }
    }

    return totalSubmatrices;
};