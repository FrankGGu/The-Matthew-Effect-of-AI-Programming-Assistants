function maximumScore(s, k) {
    const n = s.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    let count = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === 'a') count++;
        else count = 0;
        left[i] = count;
    }

    count = 0;
    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === 'b') count++;
        else count = 0;
        right[i] = count;
    }

    let maxScore = 0;
    for (let i = 0; i < n; i++) {
        if (i === k) continue;
        maxScore = Math.max(maxScore, left[i] + right[i]);
    }

    return maxScore;
}