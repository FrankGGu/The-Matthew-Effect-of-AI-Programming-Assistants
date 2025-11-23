function canReplaceAll(s, t, c, k) {
    const n = s.length;
    const m = t.length;
    if (m > n) return false;
    const map = new Map();
    for (let i = 0; i < m; i++) {
        const key = t[i];
        if (!map.has(key)) {
            map.set(key, []);
        }
        map.get(key).push(i);
    }
    const pos = [];
    for (let i = 0; i < n; i++) {
        if (s[i] === c) {
            pos.push(i);
        }
    }
    let j = 0;
    for (let i = 0; i < m; i++) {
        const key = t[i];
        const indices = map.get(key);
        if (!indices) return false;
        while (j < pos.length && pos[j] < indices[0]) {
            j++;
        }
        if (j >= pos.length) return false;
        if (pos[j] !== indices[0]) return false;
        j++;
    }
    return true;
}