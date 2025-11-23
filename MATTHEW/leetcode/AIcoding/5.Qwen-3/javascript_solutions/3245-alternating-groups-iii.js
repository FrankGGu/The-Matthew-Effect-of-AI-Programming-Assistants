function numberOfAlternatingGroups(s) {
    const n = s.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        const a = s[i];
        const b = s[(i + 1) % n];
        const c = s[(i + 2) % n];
        if (a !== b && b !== c && a !== c) {
            count++;
        }
    }
    return count;
}