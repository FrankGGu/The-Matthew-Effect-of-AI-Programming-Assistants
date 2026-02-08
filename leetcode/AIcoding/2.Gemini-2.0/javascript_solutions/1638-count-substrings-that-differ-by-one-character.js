var countSubstrings = function(s, t) {
    let n = s.length;
    let m = t.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            let diff = 0;
            for (let k = 0; i + k < n && j + k < m; k++) {
                if (s[i + k] !== t[j + k]) {
                    diff++;
                }
                if (diff === 1) {
                    count++;
                } else if (diff > 1) {
                    break;
                }
            }
        }
    }

    return count;
};