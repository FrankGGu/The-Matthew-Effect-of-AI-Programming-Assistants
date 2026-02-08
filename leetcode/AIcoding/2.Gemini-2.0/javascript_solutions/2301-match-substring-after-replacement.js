var matchReplacement = function(s, sub, mappings) {
    const map = new Map();
    for (const [char, rep] of mappings) {
        if (!map.has(char)) {
            map.set(char, new Set());
        }
        map.get(char).add(rep);
    }

    for (let i = 0; i <= s.length - sub.length; i++) {
        let match = true;
        for (let j = 0; j < sub.length; j++) {
            if (s[i + j] === sub[j]) {
                continue;
            }
            if (map.has(sub[j]) && map.get(sub[j]).has(s[i + j])) {
                continue;
            }
            match = false;
            break;
        }
        if (match) {
            return true;
        }
    }

    return false;
};