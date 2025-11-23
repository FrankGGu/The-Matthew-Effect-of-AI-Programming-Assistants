var findAnagrams = function(s, p) {
    const result = [];
    const sLen = s.length;
    const pLen = p.length;

    if (sLen < pLen) {
        return result;
    }

    const pCharCounts = new Array(26).fill(0);
    for (let i = 0; i < pLen; i++) {
        pCharCounts[p.charCodeAt(i) - 97]++;
    }

    let windowLeft = 0;
    let charsToMatch = pLen; 

    for (let windowRight = 0; windowRight < sLen; windowRight++) {
        const charR_idx = s.charCodeAt(windowRight) - 97;

        if (pCharCounts[charR_idx] > 0) {
            charsToMatch--;
        }
        pCharCounts[charR_idx]--;

        if (windowRight - windowLeft + 1 === pLen) {
            if (charsToMatch === 0) {
                result.push(windowLeft);
            }

            const charL_idx = s.charCodeAt(windowLeft) - 97;
            pCharCounts[charL_idx]++;
            if (pCharCounts[charL_idx] > 0) {
                charsToMatch++;
            }
            windowLeft++;
        }
    }

    return result;
};