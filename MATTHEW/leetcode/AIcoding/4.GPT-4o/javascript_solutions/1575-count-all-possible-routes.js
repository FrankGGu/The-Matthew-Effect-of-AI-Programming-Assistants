var countRoutes = function(locations, start, finish, fuel) {
    const mod = 1e9 + 7;
    const n = locations.length;
    const dp = Array.from({ length: n }, () => Array(fuel + 1).fill(-1));

    const dfs = (pos, remainingFuel) => {
        if (remainingFuel < 0) return 0;
        if (dp[pos][remainingFuel] !== -1) return dp[pos][remainingFuel];

        let count = pos === finish ? 1 : 0;
        for (let next = 0; next < n; next++) {
            if (next !== pos) {
                const cost = Math.abs(locations[next] - locations[pos]);
                count = (count + dfs(next, remainingFuel - cost)) % mod;
            }
        }
        return dp[pos][remainingFuel] = count;
    };

    return dfs(start, fuel);
};