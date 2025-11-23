function findRotateSteps(ring, key) {
    const n = ring.length;
    const m = key.length;
    const memo = {};

    function dfs(pos, k) {
        if (k === m) return 0;
        const keyChar = key[k];
        const keyPos = `${pos},${k}`;
        if (memo[keyPos] !== undefined) return memo[keyPos];

        let minSteps = Infinity;
        for (let i = 0; i < n; i++) {
            if (ring[i] === keyChar) {
                const steps = Math.min(Math.abs(pos - i), n - Math.abs(pos - i)) + 1;
                minSteps = Math.min(minSteps, steps + dfs(i, k + 1));
            }
        }

        memo[keyPos] = minSteps;
        return minSteps;
    }

    return dfs(0, 0);
}