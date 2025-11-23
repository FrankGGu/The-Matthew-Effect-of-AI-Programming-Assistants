var checkString = function(s) {
    let oneSegmentEnded = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            oneSegmentEnded = true;
        } else if (oneSegmentEnded) {
            return false;
        }
    }
    return true;
};