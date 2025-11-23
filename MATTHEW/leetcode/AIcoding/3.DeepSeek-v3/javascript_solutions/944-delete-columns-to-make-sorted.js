var minDeletionSize = function(strs) {
    let count = 0;
    const n = strs.length;
    const m = strs[0].length;

    for (let j = 0; j < m; j++) {
        for (let i = 1; i < n; i++) {
            if (strs[i][j] < strs[i - 1][j]) {
                count++;
                break;
            }
        }
    }

    return count;
};