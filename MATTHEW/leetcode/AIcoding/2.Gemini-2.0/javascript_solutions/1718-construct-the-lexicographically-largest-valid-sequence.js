var constructDistancedSequence = function(n) {
    const result = new Array(2 * n - 1).fill(0);
    const used = new Array(n + 1).fill(false);

    function backtrack(index) {
        if (index === 2 * n - 1) {
            return true;
        }

        if (result[index] !== 0) {
            return backtrack(index + 1);
        }

        for (let num = n; num >= 1; num--) {
            if (!used[num]) {
                if (num === 1) {
                    result[index] = num;
                    used[num] = true;
                    if (backtrack(index + 1)) {
                        return true;
                    }
                    result[index] = 0;
                    used[num] = false;
                } else if (index + num < 2 * n - 1 && result[index + num] === 0) {
                    result[index] = num;
                    result[index + num] = num;
                    used[num] = true;
                    if (backtrack(index + 1)) {
                        return true;
                    }
                    result[index] = 0;
                    result[index + num] = 0;
                    used[num] = false;
                }
            }
        }

        return false;
    }

    backtrack(0);
    return result;
};