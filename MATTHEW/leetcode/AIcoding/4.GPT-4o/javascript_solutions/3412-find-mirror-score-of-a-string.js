var mirrorScore = function(s) {
    let score = 0;
    const n = s.length;
    for (let i = 0; i < Math.floor(n / 2); i++) {
        if (s[i] === s[n - i - 1]) {
            score++;
        }
    }
    return score;
};