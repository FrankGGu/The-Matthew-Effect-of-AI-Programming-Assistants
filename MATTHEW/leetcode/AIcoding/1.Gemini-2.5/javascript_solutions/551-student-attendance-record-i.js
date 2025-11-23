var checkRecord = function(s) {
    let absentCount = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'A') {
            absentCount++;
        }
        if (absentCount >= 2) {
            return false;
        }
    }

    if (s.includes("LLL")) {
        return false;
    }

    return true;
};