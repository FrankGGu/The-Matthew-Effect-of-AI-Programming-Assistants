var isTransformable = function(s, t) {
    const pos = Array.from({ length: 10 }, () => []);
    for (let i = 0; i < s.length; i++) {
        const digit = parseInt(s[i]);
        pos[digit].push(i);
    }

    for (let i = 0; i < t.length; i++) {
        const digit = parseInt(t[i]);
        if (pos[digit].length === 0) return false;

        for (let d = 0; d < digit; d++) {
            if (pos[d].length > 0 && pos[d][0] < pos[digit][0]) {
                return false;
            }
        }
        pos[digit].shift();
    }
    return true;
};