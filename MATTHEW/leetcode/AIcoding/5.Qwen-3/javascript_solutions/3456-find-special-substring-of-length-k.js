function findSpecialSubstrings(s, k) {
    const n = s.length;
    const result = new Set();

    for (let i = 0; i <= n - k; i++) {
        const substring = s.substring(i, i + k);
        const chars = new Set(substring);
        if (chars.size === 1) {
            result.add(substring);
        }
    }

    return Array.from(result);
}