var minFlipsMonoIncr = function(s) {
    let ones = 0;
    let flips = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            ones++;
        } else {
            flips++;
        }
        flips = Math.min(ones, flips);
    }

    return flips;
};