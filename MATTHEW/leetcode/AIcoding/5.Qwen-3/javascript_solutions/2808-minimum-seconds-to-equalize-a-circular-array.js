function minimumSeconds(s) {
    const n = s.length;
    const map = new Map();
    for (let i = 0; i < n; i++) {
        const c = s[i];
        if (!map.has(c)) {
            map.set(c, []);
        }
        map.get(c).push(i);
    }

    let minDist = n;
    for (const indices of map.values()) {
        for (let i = 0; i < indices.length - 1; i++) {
            const dist = indices[i + 1] - indices[i];
            minDist = Math.min(minDist, dist);
        }
    }

    return Math.ceil(n / minDist);
}