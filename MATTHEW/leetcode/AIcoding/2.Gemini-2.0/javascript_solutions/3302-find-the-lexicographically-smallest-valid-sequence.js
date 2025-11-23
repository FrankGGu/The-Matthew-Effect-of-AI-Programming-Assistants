var smallestLexicalOrder = function(n) {
    const result = new Array(2 * n - 1).fill(0);
    const used = new Array(n + 1).fill(false);

    function backtrack(index) {
        if (index === 2 * n - 1) {
            return true;
        }

        for (let i = n; i >= 1; i--) {
            if (!used[i]) {
                if (i === 1) {
                    result[index] = i;
                    used[i] = true;
                    if (backtrack(index + 1)) {
                        return true;
                    }
                    used[i] = false;
                    result[index] = 0;
                } else {
                    if (index + i < 2 * n && result[index + i] === 0) {
                        result[index] = i;
                        result[index + i] = i;
                        used[i] = true;
                        if (backtrack(index + 1)) {
                            return true;
                        }
                        used[i] = false;
                        result[index] = 0;
                        result[index + i] = 0;
                    }
                }
            }
        }
        return false;
    }

    backtrack(0);
    return result;
};