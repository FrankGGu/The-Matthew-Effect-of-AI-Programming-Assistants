var shortestToChar = function(s, c) {
    const n = s.length;
    const ans = new Array(n).fill(Infinity);

    for (let i = 0; i < n; i++) {
        if (s[i] === c) {
            ans[i] = 0;
        }
    }

    for (let i = 0; i < n; i++) {
        if (s[i] === c) {
            for (let j = 0; j < n; j++) {
                ans[j] = Math.min(ans[j], Math.abs(i - j));
            }
        }
    }

    return ans;
};