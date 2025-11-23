var findRotateSteps = function(ring, key) {
    const n = ring.length;
    const m = key.length;
    const pos = new Array(26).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        pos[ring.charCodeAt(i) - 'a'.charCodeAt(0)].push(i);
    }

    const dp = new Array(m).fill(null).map(() => new Array(n).fill(Infinity));

    for (const p of pos[key.charCodeAt(0) - 'a'.charCodeAt(0)]) {
        dp[0][p] = Math.min(p, n - p) + 1;
    }

    for (let i = 1; i < m; i++) {
        for (const p of pos[key.charCodeAt(i) - 'a'.charCodeAt(0)]) {
            for (const prev of pos[key.charCodeAt(i - 1) - 'a'.charCodeAt(0)]) {
                const diff = Math.abs(p - prev);
                const cost = Math.min(diff, n - diff);
                dp[i][p] = Math.min(dp[i][p], dp[i - 1][prev] + cost + 1);
            }
        }
    }

    let res = Infinity;
    for (const p of pos[key.charCodeAt(m - 1) - 'a'.charCodeAt(0)]) {
        res = Math.min(res, dp[m - 1][p]);
    }

    return res;
};