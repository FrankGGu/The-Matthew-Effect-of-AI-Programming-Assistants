var sumScores = function(s) {
    const n = s.length;
    const Z = new Array(n).fill(0);

    Z[0] = n;

    let L = 0, R = 0;

    for (let i = 1; i < n; i++) {
        if (i <= R) {
            Z[i] = Math.min(R - i + 1, Z[i - L]);
        }
        while (i + Z[i] < n && s[Z[i]] === s[i + Z[i]]) {
            Z[i]++;
        }
        if (i + Z[i] - 1 > R) {
            L = i;
            R = i + Z[i] - 1;
        }
    }

    let totalScore = 0;
    for (let i = 0; i < n; i++) {
        totalScore += Z[i];
    }
    return totalScore;
};