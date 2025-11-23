var matchReplacement = function(s, sub, mappings) {
    const sLen = s.length;
    const subLen = sub.length;

    if (subLen === 0) {
        return true;
    }

    const replacementMap = new Map();
    for (const [fromChar, toChar] of mappings) {
        if (!replacementMap.has(fromChar)) {
            replacementMap.set(fromChar, new Set());
        }
        replacementMap.get(fromChar).add(toChar);
    }

    for (let i = 0; i <= sLen - subLen; i++) {
        let currentMatch = true;
        for (let j = 0; j < subLen; j++) {
            const sChar = s[i + j];
            const subChar = sub[j];

            if (sChar === subChar) {
                continue;
            }

            if (replacementMap.has(sChar) && replacementMap.get(sChar).has(subChar)) {
                continue;
            }

            currentMatch = false;
            break;
        }

        if (currentMatch) {
            return true;
        }
    }

    return false;
};