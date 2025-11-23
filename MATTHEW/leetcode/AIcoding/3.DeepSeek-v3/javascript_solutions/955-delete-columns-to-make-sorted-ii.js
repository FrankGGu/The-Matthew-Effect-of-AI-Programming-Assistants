var minDeletionSize = function(strs) {
    let res = 0;
    const n = strs.length;
    const m = strs[0].length;
    const sorted = new Array(n).fill(false);

    for (let j = 0; j < m; j++) {
        let i = 0;
        for (; i < n - 1; i++) {
            if (!sorted[i] && strs[i].charAt(j) > strs[i + 1].charAt(j)) {
                res++;
                break;
            }
        }
        if (i < n - 1) continue;

        for (i = 0; i < n - 1; i++) {
            if (strs[i].charAt(j) < strs[i + 1].charAt(j)) {
                sorted[i] = true;
            }
        }
    }

    return res;
};