var canConvertString = function(s, t, k) {
    if (s.length !== t.length) return false;
    const shifts = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        const diff = (t.charCodeAt(i) - s.charCodeAt(i) + 26) % 26;
        if (diff === 0) continue;
        if (diff + shifts[diff] * 26 > k) {
            return false;
        }
        shifts[diff]++;
    }
    return true;
};