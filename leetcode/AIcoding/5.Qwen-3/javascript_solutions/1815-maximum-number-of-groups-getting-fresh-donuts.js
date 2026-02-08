function maxHappyGroups(house) {
    const n = house.length;
    const mod = new Array(10).fill(0);
    for (let i = 0; i < n; i++) {
        mod[house[i] % 10]++;
    }

    const dp = {};
    function dfs(cnt, rem) {
        const key = cnt + ',' + rem;
        if (dp[key] !== undefined) return dp[key];
        if (cnt === 0) return 0;
        let max = 0;
        for (let i = 0; i < 10; i++) {
            if (mod[i] === 0) continue;
            mod[i]--;
            let nextRem = (rem + i) % 10;
            if (nextRem === 0) {
                max = Math.max(max, 1 + dfs(cnt - 1, nextRem));
            } else {
                max = Math.max(max, dfs(cnt - 1, nextRem));
            }
            mod[i]++;
        }
        dp[key] = max;
        return max;
    }

    return dfs(n, 0);
}