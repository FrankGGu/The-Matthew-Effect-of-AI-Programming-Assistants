function findFirstAlmostEqualSubstring(s, t) {
    const n = s.length;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n - i; j++) {
            if (s[i + j] !== t[j]) count++;
            if (count > 1) break;
            if (j === n - i - 1 && count <= 1) return i;
        }
    }
    return -1;
}