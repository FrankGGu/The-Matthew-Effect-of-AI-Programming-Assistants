var shiftDistance = function(s, t) {
    if (s.length !== t.length) {
        return -1;
    }

    for (let i = 0; i < s.length; i++) {
        let shiftedS = s.substring(i) + s.substring(0, i);
        if (shiftedS === t) {
            return i;
        }
    }

    return -1;
};