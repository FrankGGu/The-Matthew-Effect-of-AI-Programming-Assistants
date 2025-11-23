function canRearrange(s, t, k) {
    const count = {};
    for (let c of s) {
        count[c] = (count[c] || 0) + 1;
    }
    for (let c of t) {
        count[c] = (count[c] || 0) - 1;
    }
    for (let key in count) {
        if (count[key] < 0) return false;
    }
    let freq = {};
    for (let i = 0; i < t.length; i++) {
        freq[t[i]] = (freq[t[i]] || 0) + 1;
    }
    let maxFreq = Math.max(...Object.values(freq));
    return maxFreq <= k;
}