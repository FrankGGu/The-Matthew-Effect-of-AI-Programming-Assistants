var hasAllCodes = function(s, k) {
    const seenCodes = new Set();
    const numPossibleCodes = Math.pow(2, k);

    if (s.length < k) {
        return false;
    }

    for (let i = 0; i <= s.length - k; i++) {
        const sub = s.substring(i, i + k);
        seenCodes.add(sub);
        if (seenCodes.size === numPossibleCodes) {
            return true;
        }
    }

    return seenCodes.size === numPossibleCodes;
};