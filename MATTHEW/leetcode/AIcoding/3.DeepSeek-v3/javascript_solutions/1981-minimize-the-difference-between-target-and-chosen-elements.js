var minimizeTheDifference = function(mat, target) {
    const m = mat.length;
    const n = mat[0].length;
    let dp = new Set();
    dp.add(0);

    for (let i = 0; i < m; i++) {
        const newDp = new Set();
        let min = Infinity;
        for (const sum of dp) {
            for (let j = 0; j < n; j++) {
                const newSum = sum + mat[i][j];
                if (newSum <= 2 * target) {
                    newDp.add(newSum);
                } else {
                    if (newSum < min) {
                        min = newSum;
                    }
                }
            }
        }
        if (min !== Infinity) {
            newDp.add(min);
        }
        dp = newDp;
    }

    let minDiff = Infinity;
    for (const sum of dp) {
        const diff = Math.abs(sum - target);
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    return minDiff;
};