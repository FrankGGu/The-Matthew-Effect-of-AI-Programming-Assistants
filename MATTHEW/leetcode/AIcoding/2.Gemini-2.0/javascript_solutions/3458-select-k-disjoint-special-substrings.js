var maxHappyGroups = function(s, k, special) {
    const n = s.length;
    const m = special.length;
    let count = 0;
    let used = new Array(n).fill(false);

    function isSpecial(start, len) {
        if (start + len > n) return false;
        let sub = s.substring(start, start + len);
        return sub === special;
    }

    function solve(remaining) {
        if (remaining === 0) return 0;
        let max = -1;
        for (let i = 0; i < n; i++) {
            if (!used[i]) {
                for (let len = 1; len <= m; len++) {
                    if (isSpecial(i, len)) {
                        let newUsed = new Array(n).fill(false);
                        for(let j = 0; j < n; j++) {
                            newUsed[j] = used[j];
                        }
                        for (let j = i; j < i + len; j++) {
                            newUsed[j] = true;
                        }
                        let newRemaining = remaining - len;
                        if (newRemaining >= 0) {
                            max = Math.max(max, 1 + solve(newRemaining));
                        }
                    }
                }
            }
        }
        return max === -1 ? 0 : max;
    }

    return solve(n);
};