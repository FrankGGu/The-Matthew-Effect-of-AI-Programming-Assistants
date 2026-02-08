var canMatch = function(s, sub, mappings) {
    const map = new Map();
    for (const [oldChar, newChar] of mappings) {
        if (!map.has(oldChar)) {
            map.set(oldChar, new Set());
        }
        map.get(oldChar).add(newChar);
    }

    const n = s.length;
    const m = sub.length;

    for (let i = 0; i <= n - m; i++) {
        let match = true;
        for (let j = 0; j < m; j++) {
            const sChar = s[i + j];
            const subChar = sub[j];
            if (sChar === subChar) {
                continue;
            }
            if (!map.has(subChar) || !map.get(subChar).has(sChar)) {
                match = false;
                break;
            }
        }
        if (match) {
            return true;
        }
    }
    return false;
};