function maxCompatibilityScore(students, mentors) {
    const n = students.length;
    const m = students[0].length;
    const score = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let s = 0;
            for (let k = 0; k < m; k++) {
                s += students[i][k] === mentors[j][k] ? 1 : 0;
            }
            score[i][j] = s;
        }
    }

    const dp = new Array(1 << n).fill(0);

    for (let mask = 0; mask < (1 << n); mask++) {
        const cnt = bitCount(mask);
        if (cnt === 0) continue;
        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                const prevMask = mask ^ (1 << i);
                dp[mask] = Math.max(dp[mask], dp[prevMask] + score[cnt - 1][i]);
            }
        }
    }

    return dp[(1 << n) - 1];
}

function bitCount(x) {
    let count = 0;
    while (x) {
        count += x & 1;
        x >>= 1;
    }
    return count;
}