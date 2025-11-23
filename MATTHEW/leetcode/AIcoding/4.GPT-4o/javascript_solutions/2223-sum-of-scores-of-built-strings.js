var sumScores = function(s) {
    const n = s.length;
    const lps = new Array(n).fill(0);
    let j = 0;

    for (let i = 1; i < n; i++) {
        while (j > 0 && s[i] !== s[j]) {
            j = lps[j - 1];
        }
        if (s[i] === s[j]) {
            j++;
            lps[i] = j;
        } else {
            lps[i] = 0;
        }
    }

    let totalScore = n;
    for (let i = n - 1; i > 0; i--) {
        totalScore += lps[i];
    }

    return totalScore;
};