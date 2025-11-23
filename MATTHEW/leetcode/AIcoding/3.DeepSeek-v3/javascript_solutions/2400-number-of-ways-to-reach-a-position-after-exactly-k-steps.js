var numberOfWays = function(startPos, endPos, k) {
    const MOD = 1e9 + 7;
    const memo = new Map();

    function dfs(pos, steps) {
        if (steps === 0) {
            return pos === endPos ? 1 : 0;
        }
        const key = `${pos},${steps}`;
        if (memo.has(key)) {
            return memo.get(key);
        }
        const ways = (dfs(pos + 1, steps - 1) + dfs(pos - 1, steps - 1)) % MOD;
        memo.set(key, ways);
        return ways;
    }

    return dfs(startPos, k);
};