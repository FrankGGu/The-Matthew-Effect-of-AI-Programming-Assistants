function isTransformable(s, t) {
    const pos = Array.from({ length: 10 }, () => []);
    for (let i = 0; i < s.length; i++) {
        pos[s.charCodeAt(i) - '0'.charCodeAt(0)].push(i);
    }
    for (let i = 0; i < t.length; i++) {
        const c = t.charCodeAt(i) - '0'.charCodeAt(0);
        if (pos[c].length === 0) return false;
        const idx = pos[c].pop();
        for (let j = c + 1; j < 10; j++) {
            if (pos[j].length > 0 && pos[j][pos[j].length - 1] < idx) return false;
        }
    }
    return true;
}