var countSubstrings = function(s, t) {
    let count = 0;
    let lenS = s.length;
    let lenT = t.length;

    for (let i = 0; i < lenS; i++) {
        for (let j = 0; j < lenT; j++) {
            let diff = 0;
            for (let k = 0; k < Math.max(lenS - i, lenT - j); k++) {
                const charS = s[i + k] || '';
                const charT = t[j + k] || '';
                if (charS !== charT) {
                    diff++;
                }
                if (diff > 1) break;
            }
            if (diff === 1) count++;
        }
    }

    return count;
};