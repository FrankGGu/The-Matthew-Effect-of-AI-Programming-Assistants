var checkRecord = function(s) {
    let absentCount = 0;
    let lateCount = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'A') {
            absentCount++;
            lateCount = 0;
            if (absentCount > 1) {
                return false;
            }
        } else if (s[i] === 'L') {
            lateCount++;
            if (lateCount > 2) {
                return false;
            }
        } else {
            lateCount = 0;
        }
    }

    return true;
};