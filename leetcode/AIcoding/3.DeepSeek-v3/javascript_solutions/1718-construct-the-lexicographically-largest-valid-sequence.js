var constructDistancedSequence = function(n) {
    const size = 2 * n - 1;
    const result = new Array(size).fill(0);
    const used = new Array(n + 1).fill(false);

    const backtrack = (pos) => {
        if (pos === size) {
            return true;
        }
        if (result[pos] !== 0) {
            return backtrack(pos + 1);
        }
        for (let num = n; num >= 1; num--) {
            if (used[num]) continue;
            if (num === 1) {
                result[pos] = num;
                used[num] = true;
                if (backtrack(pos + 1)) {
                    return true;
                }
                used[num] = false;
                result[pos] = 0;
            } else {
                if (pos + num >= size || result[pos + num] !== 0) continue;
                result[pos] = num;
                result[pos + num] = num;
                used[num] = true;
                if (backtrack(pos + 1)) {
                    return true;
                }
                used[num] = false;
                result[pos] = 0;
                result[pos + num] = 0;
            }
        }
        return false;
    };

    backtrack(0);
    return result;
};