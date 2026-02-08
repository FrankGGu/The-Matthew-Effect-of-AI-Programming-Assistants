var isMatch = function(s, p) {
    let sIndex = 0, pIndex = 0;
    let starIndex = -1, sTempIndex = -1;

    while (sIndex < s.length) {
        if (pIndex < p.length && (p[pIndex] === '?' || p[pIndex] === s[sIndex])) {
            sIndex++;
            pIndex++;
        } else if (pIndex < p.length && p[pIndex] === '*') {
            starIndex = pIndex;
            sTempIndex = sIndex;
            pIndex++;
        } else if (starIndex !== -1) {
            pIndex = starIndex + 1;
            sIndex = sTempIndex + 1;
            sTempIndex = sIndex;
        } else {
            return false;
        }
    }

    while (pIndex < p.length && p[pIndex] === '*') {
        pIndex++;
    }

    return pIndex === p.length;
};