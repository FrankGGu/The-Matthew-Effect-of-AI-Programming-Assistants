function canConvertString(s, t, k) {
    if (s.length !== t.length) return false;

    const count = new Array(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        const a = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const b = t.charCodeAt(i) - 'a'.charCodeAt(0);
        if (a === b) continue;
        const diff = (b - a + 26) % 26;
        if (count[diff] >= k) return false;
        count[diff]++;
    }

    return true;
}