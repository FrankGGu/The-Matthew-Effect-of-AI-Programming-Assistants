var waysToBuildRooms = function(parent) {
    const n = parent.length;
    const MOD = 10**9 + 7;

    const adj = Array(n).fill(0).map(() => []);
    for (let i = 1; i < n; i++) {
        adj[parent[i]].push(i);
    }

    const fact = Array(n + 1);
    const invFact = Array(n + 1);

    fact[0] = 1;
    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }

    const power = (base, exp) => {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    const modInverse = (num) => power(num, MOD - 2);

    invFact[n] = modInverse(fact[n]);
    for (let i = n - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }

    const dfs = (u) => {
        let currentSize = 1;
        let ways = 1;

        for (const v of adj[u]) {
            const [childSize, childWays] = dfs(v);

            currentSize += childSize;

            ways = (ways * childWays) % MOD;
            ways = (ways * invFact[childSize]) % MOD;
        }

        ways = (ways * fact[currentSize - 1]) % MOD;

        return [currentSize, ways];
    };

    const [totalSize, totalWays] = dfs(0);
    return totalWays;
};