var maximumScore = function(s) {
    let maxScore = 0;
    let countA = 0, countB = 0;

    for (let char of s) {
        if (char === 'A') countA++;
    }

    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'A') {
            countA--;
        } else {
            countB++;
        }
        maxScore = Math.max(maxScore, countA + countB);
    }

    return maxScore;
};