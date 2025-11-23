var minDeletionSize = function(strs) {
    const n = strs.length;
    const m = strs[0].length;
    let ans = 0;
    let sorted = new Array(n).fill(false);

    for (let j = 0; j < m; j++) {
        let needDelete = false;
        for (let i = 0; i < n - 1; i++) {
            if (!sorted[i] && strs[i][j] > strs[i + 1][j]) {
                needDelete = true;
                break;
            }
        }

        if (needDelete) {
            ans++;
        } else {
            for (let i = 0; i < n - 1; i++) {
                if (strs[i][j] < strs[i + 1][j]) {
                    sorted[i] = true;
                }
            }
        }
    }

    return ans;
};