function hasAllCodesToMakePassword(s, k) {
    const set = new Set();
    const n = s.length;
    for (let i = 0; i <= n - k; i++) {
        set.add(s.substring(i, i + k));
    }
    const required = 1 << k;
    return set.size >= required;
}