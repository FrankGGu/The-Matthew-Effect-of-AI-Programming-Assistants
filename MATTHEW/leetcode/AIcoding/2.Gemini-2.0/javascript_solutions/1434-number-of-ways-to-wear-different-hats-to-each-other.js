var numberWays = function(hats) {
    const MOD = 10**9 + 7;
    const n = hats.length;
    const hatToPeople = new Array(41).fill(null).map(() => []);
    for (let i = 0; i < n; i++) {
        for (const hat of hats[i]) {
            hatToPeople[hat].push(i);
        }
    }

    const memo = new Map();

    function dp(hatId, mask) {
        if (mask === (1 << n) - 1) {
            return 1;
        }

        if (hatId > 40) {
            return 0;
        }

        const key = `${hatId}-${mask}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let ans = dp(hatId + 1, mask);

        for (const person of hatToPeople[hatId]) {
            if ((mask & (1 << person)) === 0) {
                ans = (ans + dp(hatId + 1, mask | (1 << person))) % MOD;
            }
        }

        memo.set(key, ans);
        return ans;
    }

    return dp(1, 0);
};