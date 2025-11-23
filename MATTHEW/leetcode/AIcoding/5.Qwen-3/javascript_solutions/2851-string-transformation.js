function strTransform(s, t) {
    if (s.length !== t.length) return false;
    const map = {};
    const used = new Set();
    for (let i = 0; i < s.length; i++) {
        const charS = s[i];
        const charT = t[i];
        if (map[charS] && map[charS] !== charT) return false;
        if (!map[charS] && used.has(charT)) return false;
        map[charS] = charT;
        used.add(charT);
    }
    return true;
}