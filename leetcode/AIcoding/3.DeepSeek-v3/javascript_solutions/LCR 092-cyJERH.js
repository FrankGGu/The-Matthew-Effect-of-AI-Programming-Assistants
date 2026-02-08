var minFlipsMonoIncr = function(s) {
    let flipCount = 0;
    let onesCount = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            onesCount++;
        } else {
            flipCount = Math.min(flipCount + 1, onesCount);
        }
    }

    return flipCount;
};