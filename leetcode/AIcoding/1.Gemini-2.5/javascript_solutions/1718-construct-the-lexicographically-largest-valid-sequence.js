var constructDistancedSequence = function(n) {
    const len = 2 * n - 1;
    const ans = new Array(len).fill(0);
    const used = new Array(n + 1).fill(false);

    function backtrack(index) {
        if (index === len) {
            return true;
        }

        if (ans[index] !== 0) {
            return backtrack(index + 1);
        }

        for (let i = n; i >= 1; i--) {
            if (used[i]) {
                continue;
            }

            if (i === 1) {
                ans[index] = 1;
                used[1] = true;
                if (backtrack(index + 1)) {
                    return true;
                }
                used[1] = false;
                ans[index] = 0;
            } else {
                const secondPos = index + i;
                if (secondPos < len && ans[secondPos] === 0) {
                    ans[index] = i;
                    ans[secondPos] = i;
                    used[i] = true;
                    if (backtrack(index + 1)) {
                        return true;
                    }
                    used[i] = false;
                    ans[index] = 0;
                    ans[secondPos] = 0;
                }
            }
        }
        return false;
    }

    backtrack(0);
    return ans;
};