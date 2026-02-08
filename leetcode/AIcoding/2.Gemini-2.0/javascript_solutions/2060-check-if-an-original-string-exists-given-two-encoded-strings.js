var possiblyEquals = function(s1, s2) {
    const m = s1.length;
    const n = s2.length;
    const dp = new Array(m + 1).fill(null).map(() => new Array(n + 1).fill(null).map(() => new Array(2001).fill(false)));

    function isDigit(c) {
        return c >= '0' && c <= '9';
    }

    function solve(i, j, diff) {
        if (i === m && j === n) {
            return diff === 0;
        }
        if (dp[i][j][diff + 1000]) {
            return false;
        }

        dp[i][j][diff + 1000] = true;

        if (i < m && !isDigit(s1[i]) && diff > 0) {
            if (solve(i, j, diff - 1)) {
                return true;
            }
        }

        if (j < n && !isDigit(s2[j]) && diff < 0) {
            if (solve(i, j, diff + 1)) {
                return true;
            }
        }

        if (i < m && j < n && !isDigit(s1[i]) && !isDigit(s2[j]) && s1[i] === s2[j]) {
            if (solve(i + 1, j + 1, diff)) {
                return true;
            }
        }

        if (i < m && isDigit(s1[i])) {
            let num = 0;
            for (let k = i; k < m; k++) {
                if (!isDigit(s1[k])) {
                    break;
                }
                num = num * 10 + (s1[k].charCodeAt(0) - '0'.charCodeAt(0));
                if (solve(k + 1, j, diff + num)) {
                    return true;
                }
            }
        }

        if (j < n && isDigit(s2[j])) {
            let num = 0;
            for (let k = j; k < n; k++) {
                if (!isDigit(s2[k])) {
                    break;
                }
                num = num * 10 + (s2[k].charCodeAt(0) - '0'.charCodeAt(0));
                if (solve(i, k + 1, diff - num)) {
                    return true;
                }
            }
        }

        return false;
    }

    return solve(0, 0, 0);
};