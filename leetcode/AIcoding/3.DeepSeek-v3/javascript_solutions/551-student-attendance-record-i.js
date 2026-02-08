var checkRecord = function(s) {
    let absentCount = 0;
    let lateStreak = 0;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === 'A') {
            absentCount++;
            lateStreak = 0;
            if (absentCount >= 2) {
                return false;
            }
        } else if (char === 'L') {
            lateStreak++;
            if (lateStreak >= 3) {
                return false;
            }
        } else {
            lateStreak = 0;
        }
    }

    return true;
};