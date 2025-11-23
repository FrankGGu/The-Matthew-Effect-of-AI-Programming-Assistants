function findFirstAlmostEqualSubstring(s, t, allowedDifference) {
    const n = s.length;
    const m = t.length;

    for (let i = 0; i <= n - m; i++) {
        let diff = 0;
        for (let j = 0; j < m; j++) {
            if (s[i + j] !== t[j]) {
                diff++;
                if (diff > allowedDifference) break;
            }
        }
        if (diff <= allowedDifference) return i;
    }

    return -1;
}