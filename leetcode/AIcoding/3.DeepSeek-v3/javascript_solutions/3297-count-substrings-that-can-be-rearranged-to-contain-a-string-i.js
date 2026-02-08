var countSubstrings = function(s, t) {
    let count = 0;
    const m = s.length;
    const n = t.length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let diff = 0;
            let k = 0;
            while (i + k < m && j + k < n) {
                if (s[i + k] !== t[j + k]) {
                    diff++;
                }
                if (diff > 1) {
                    break;
                }
                if (diff === 1) {
                    count++;
                }
                k++;
            }
        }
    }

    return count;
};