var countSubstrings = function(s, t) {
    let count = 0;
    const m = s.length, n = t.length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let diff = 0;
            for (let k = 0; k < Math.min(m - i, n - j); k++) {
                if (s[i + k] !== t[j + k]) {
                    diff++;
                }
                if (diff > 1) break;
                if (diff === 1) count++;
            }
        }
    }
    return count;
};