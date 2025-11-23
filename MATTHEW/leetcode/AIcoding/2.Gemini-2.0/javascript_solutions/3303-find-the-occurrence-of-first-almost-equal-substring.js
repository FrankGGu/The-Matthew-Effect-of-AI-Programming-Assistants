var findFirstOccurrence = function(s, t, k) {
    for (let i = 0; i <= s.length - t.length; i++) {
        let diff = 0;
        for (let j = 0; j < t.length; j++) {
            if (s[i + j] !== t[j]) {
                diff++;
            }
        }
        if (diff <= k) {
            return i;
        }
    }
    return -1;
};