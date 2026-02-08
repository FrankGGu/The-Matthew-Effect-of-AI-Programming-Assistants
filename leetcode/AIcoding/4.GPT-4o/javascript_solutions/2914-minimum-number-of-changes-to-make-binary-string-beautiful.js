function minChanges(s) {
    const n = s.length;
    let changes = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            changes++;
            if (i + 1 < n) {
                i++;
            }
        }
    }

    return changes;
}