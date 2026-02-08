var countSubstrings = function(s, t) {
    const m = s.length;
    const n = t.length;
    let res = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let diff = 0;
            for (let k = 0; i + k < m && j + k < n; k++) {
                if (s[i + k] !== t[j + k]) {
                    diff++;
                }
                if (diff > 1) {
                    break;
                }
                if (diff === 1) {
                    res++;
                }
            }
        }
    }

    return res;
};