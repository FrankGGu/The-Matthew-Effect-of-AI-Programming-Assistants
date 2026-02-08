var minFlipsMonoIncr = function(s) {
    let ones = 0, flips = 0;
    for (let char of s) {
        if (char === '1') {
            ones++;
        } else {
            flips++;
            flips = Math.min(flips, ones);
        }
    }
    return flips + ones;
};