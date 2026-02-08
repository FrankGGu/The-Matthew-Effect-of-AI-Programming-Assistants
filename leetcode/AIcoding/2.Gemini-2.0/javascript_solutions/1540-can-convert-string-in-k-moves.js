var canConvertString = function(s, t, k) {
    if (s.length !== t.length) return false;
    const n = s.length;
    const diffs = new Array(26).fill(0);
    for (let i = 0; i < n; i++) {
        const diff = (t.charCodeAt(i) - s.charCodeAt(i) + 26) % 26;
        if (diff !== 0) {
            diffs[diff]++;
        }
    }

    for (let i = 1; i < 26; i++) {
        if (diffs[i] > 0) {
            if (i + (diffs[i] - 1) * 26 > k) {
                return false;
            }
        }
    }

    return true;
};