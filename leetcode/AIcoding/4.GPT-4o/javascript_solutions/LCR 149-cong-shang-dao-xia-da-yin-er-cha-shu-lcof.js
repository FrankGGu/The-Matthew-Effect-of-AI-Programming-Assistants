var checkRecord = function(s) {
    let aCount = 0, lCount = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'A') aCount++;
        if (s[i] === 'L') lCount++;
        if (lCount > 2) return false;
    }

    return aCount < 2;
};