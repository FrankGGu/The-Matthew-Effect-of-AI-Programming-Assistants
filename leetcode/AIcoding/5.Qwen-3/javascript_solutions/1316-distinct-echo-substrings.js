function countDistinctEchoSubstrings(s) {
    const n = s.length;
    const set = new Set();

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const len = j - i;
            if (j + len <= n && s.substring(i, j) === s.substring(j, j + len)) {
                set.add(s.substring(i, j));
            }
        }
    }

    return set.size;
}