function possiblyEquals(s, t) {
    const memo = {};
    function dfs(i, j, diff) {
        if (i === s.length && j === t.length) return true;
        if (i < s.length && j < t.length && s[i] === t[j]) {
            if (dfs(i + 1, j + 1, 0)) return true;
        }
        if (diff === 0) {
            let k = i;
            while (k < s.length && s[k] >= '0' && s[k] <= '9') {
                k++;
            }
            for (let l = i + 1; l <= k; l++) {
                const num = parseInt(s.substring(i, l));
                if (dfs(l, j, num)) return true;
            }
            k = j;
            while (k < t.length && t[k] >= '0' && t[k] <= '9') {
                k++;
            }
            for (let l = j + 1; l <= k; l++) {
                const num = parseInt(t.substring(j, l));
                if (dfs(i, l, -num)) return true;
            }
        } else {
            if (diff > 0) {
                let k = j;
                while (k < t.length && t[k] >= '0' && t[k] <= '9') {
                    k++;
                }
                for (let l = j + 1; l <= k; l++) {
                    const num = parseInt(t.substring(j, l));
                    if (dfs(i, l, diff - num)) return true;
                }
            } else {
                let k = i;
                while (k < s.length && s[k] >= '0' && s[k] <= '9') {
                    k++;
                }
                for (let l = i + 1; l <= k; l++) {
                    const num = parseInt(s.substring(i, l));
                    if (dfs(l, j, diff + num)) return true;
                }
            }
        }
        return false;
    }
    return dfs(0, 0, 0);
}