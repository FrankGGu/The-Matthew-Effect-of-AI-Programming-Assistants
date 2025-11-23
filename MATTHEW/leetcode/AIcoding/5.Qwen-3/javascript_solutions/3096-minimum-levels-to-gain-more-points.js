function minLevelsToGainMorePoints(s) {
    let total = 0;
    let left = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'B') {
            total--;
        } else {
            total++;
        }
    }
    let res = 0;
    let current = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'B') {
            current--;
        } else {
            current++;
        }
        if (current > 0) {
            res++;
        }
        if (current > total - current) {
            return res;
        }
    }
    return res;
}