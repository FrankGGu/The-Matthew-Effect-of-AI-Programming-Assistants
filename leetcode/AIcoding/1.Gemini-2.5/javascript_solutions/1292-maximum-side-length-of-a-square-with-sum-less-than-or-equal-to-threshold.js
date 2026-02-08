var maxSideLength = function(mat, threshold) {
    const rows = mat.length;
    const cols = mat[0].length;

    const ps = Array(rows + 1).fill(0).map(() => Array(cols + 1).fill(0));

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            ps[r + 1][c + 1] = mat[r][c] + ps[r][c + 1] + ps[r + 1][c] - ps[r][c];
        }
    }

    const getSquareSum = (r1, c1, r2, c2) => {
        return ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
    };

    const check = (k) => {
        if (k === 0) return true;
        if (k > rows || k > cols) return false;

        for (let r = 0; r <= rows - k; r++) {
            for (let c = 0; c <= cols - k; c++) {
                const currentSum = getSquareSum(r, c, r + k - 1, c + k - 1);
                if (currentSum <= threshold) {
                    return true;
                }
            }
        }
        return false;
    };

    let ans = 0;
    let low = 1;
    let high = Math.min(rows, cols);

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};