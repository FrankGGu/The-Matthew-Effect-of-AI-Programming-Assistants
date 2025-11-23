var possiblyEquals = function(s1, s2) {
    const memo = new Map();

    function dfs(i, j, diff) {
        const key = `${i},${j},${diff}`;
        if (memo.has(key)) return memo.get(key);

        if (i === s1.length && j === s2.length) {
            return diff === 0;
        }

        if (i < s1.length && !isDigit(s1[i])) {
            if (diff > 0) {
                const res = dfs(i + 1, j, diff - 1);
                memo.set(key, res);
                return res;
            } else if (diff === 0 && j < s2.length && !isDigit(s2[j]) && s1[i] === s2[j]) {
                const res = dfs(i + 1, j + 1, diff);
                memo.set(key, res);
                return res;
            } else {
                memo.set(key, false);
                return false;
            }
        }

        if (j < s2.length && !isDigit(s2[j])) {
            if (diff < 0) {
                const res = dfs(i, j + 1, diff + 1);
                memo.set(key, res);
                return res;
            } else if (diff === 0 && i < s1.length && !isDigit(s1[i]) {
                const res = dfs(i + 1, j + 1, diff);
                memo.set(key, res);
                return res;
            } else {
                memo.set(key, false);
                return false;
            }
        }

        if (diff === 0) {
            if (i < s1.length && isDigit(s1[i])) {
                let num = 0;
                for (let k = i; k < s1.length && isDigit(s1[k]); k++) {
                    num = num * 10 + parseInt(s1[k]);
                    if (dfs(k + 1, j, num)) {
                        memo.set(key, true);
                        return true;
                    }
                }
            } else if (j < s2.length && isDigit(s2[j])) {
                let num = 0;
                for (let k = j; k < s2.length && isDigit(s2[k]); k++) {
                    num = num * 10 + parseInt(s2[k]);
                    if (dfs(i, k + 1, -num)) {
                        memo.set(key, true);
                        return true;
                    }
                }
            }
        } else if (diff > 0) {
            if (i < s1.length && isDigit(s1[i])) {
                let num = 0;
                for (let k = i; k < s1.length && isDigit(s1[k]); k++) {
                    num = num * 10 + parseInt(s1[k]);
                    if (dfs(k + 1, j, diff - num)) {
                        memo.set(key, true);
                        return true;
                    }
                }
            }
        } else {
            if (j < s2.length && isDigit(s2[j])) {
                let num = 0;
                for (let k = j; k < s2.length && isDigit(s2[k]); k++) {
                    num = num * 10 + parseInt(s2[k]);
                    if (dfs(i, k + 1, diff + num)) {
                        memo.set(key, true);
                        return true;
                    }
                }
            }
        }

        memo.set(key, false);
        return false;
    }

    function isDigit(c) {
        return c >= '0' && c <= '9';
    }

    return dfs(0, 0, 0);
};