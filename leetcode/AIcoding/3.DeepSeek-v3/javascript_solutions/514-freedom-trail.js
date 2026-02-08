var findRotateSteps = function(ring, key) {
    const m = ring.length;
    const n = key.length;
    const memo = new Array(m).fill().map(() => new Array(n).fill(-1));

    const dp = (pos, k) => {
        if (k === n) return 0;
        if (memo[pos][k] !== -1) return memo[pos][k];

        let minSteps = Infinity;
        for (let i = 0; i < m; i++) {
            if (ring[i] === key[k]) {
                const diff = Math.abs(i - pos);
                const steps = Math.min(diff, m - diff) + 1 + dp(i, k + 1);
                minSteps = Math.min(minSteps, steps);
            }
        }
        memo[pos][k] = minSteps;
        return minSteps;
    };

    return dp(0, 0);
};