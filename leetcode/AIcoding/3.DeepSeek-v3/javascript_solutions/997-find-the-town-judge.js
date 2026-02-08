var findJudge = function(n, trust) {
    const trustCounts = new Array(n + 1).fill(0);
    const trustedByCounts = new Array(n + 1).fill(0);

    for (const [a, b] of trust) {
        trustCounts[a]++;
        trustedByCounts[b]++;
    }

    for (let i = 1; i <= n; i++) {
        if (trustCounts[i] === 0 && trustedByCounts[i] === n - 1) {
            return i;
        }
    }

    return -1;
};