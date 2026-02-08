var mirrorScore = function(s) {
    let n = s.length;
    let score = 0;
    let i = 0;
    while (i < n / 2 && s[i] === s[n - 1 - i]) {
        i++;
    }
    score = i;
    return score;
};