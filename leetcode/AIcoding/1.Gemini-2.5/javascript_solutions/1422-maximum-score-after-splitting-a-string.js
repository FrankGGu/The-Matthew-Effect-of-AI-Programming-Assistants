var maxScore = function(s) {
    let zerosLeft = 0;
    let onesRight = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            onesRight++;
        }
    }

    let maxScore = 0;

    for (let i = 0; i < s.length - 1; i++) {
        if (s[i] === '0') {
            zerosLeft++;
        } else {
            onesRight--;
        }

        let currentScore = zerosLeft + onesRight;
        maxScore = Math.max(maxScore, currentScore);
    }

    return maxScore;
};