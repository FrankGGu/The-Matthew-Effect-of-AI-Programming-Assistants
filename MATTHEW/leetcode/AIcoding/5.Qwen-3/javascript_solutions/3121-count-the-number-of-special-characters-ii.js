function numberOfSpecialChars(s) {
    const first = new Map();
    const last = new Map();

    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (!first.has(c)) {
            first.set(c, i);
        }
        last.set(c, i);
    }

    let count = 0;

    for (const [c, idx] of first) {
        if (last.has(c) && last.get(c) > idx) {
            count++;
        }
    }

    return count;
}