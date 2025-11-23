var maxPower = function(s) {
    if (s.length === 0) {
        return 0;
    }

    let maxP = 1;
    let currentP = 1;

    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            currentP++;
        } else {
            maxP = Math.max(maxP, currentP);
            currentP = 1;
        }
    }

    maxP = Math.max(maxP, currentP);

    return maxP;
};