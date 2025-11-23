var isTransformable = function(s, t) {
    if (s.length !== t.length) return false;

    const n = s.length;
    const pos = Array(10).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        pos[s[i]].push(i);
    }

    let ptr = Array(10).fill(0);

    for (let i = 0; i < n; i++) {
        const digit = t[i];
        if (ptr[digit] >= pos[digit].length) return false;

        for (let j = 0; j < digit; j++) {
            if (ptr[j] < pos[j].length && pos[j][ptr[j]] < pos[digit][ptr[digit]]) {
                return false;
            }
        }

        ptr[digit]++;
    }

    return true;
};