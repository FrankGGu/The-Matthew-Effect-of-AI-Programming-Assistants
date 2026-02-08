var findJudge = function(n, trust) {
    if (n === 1 && trust.length === 0) return 1;

    const trusted = new Array(n + 1).fill(0);
    const trusting = new Array(n + 1).fill(0);

    for (const [a, b] of trust) {
        trusted[b]++;
        trusting[a]++;
    }

    for (let i = 1; i <= n; i++) {
        if (trusted[i] === n - 1 && trusting[i] === 0) {
            return i;
        }
    }

    return -1;
};