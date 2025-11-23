function matchReplacement(s, sub, mappings) {
    const map = new Map();
    for (const [a, b] of mappings) {
        if (!map.has(a)) {
            map.set(a, new Set());
        }
        map.get(a).add(b);
    }

    const lenS = s.length;
    const lenSub = sub.length;

    for (let i = 0; i <= lenS - lenSub; i++) {
        let match = true;
        for (let j = 0; j < lenSub; j++) {
            const sChar = s[i + j];
            const subChar = sub[j];
            if (sChar !== subChar && (!map.has(subChar) || !map.get(subChar).has(sChar))) {
                match = false;
                break;
            }
        }
        if (match) return true;
    }
    return false;
}