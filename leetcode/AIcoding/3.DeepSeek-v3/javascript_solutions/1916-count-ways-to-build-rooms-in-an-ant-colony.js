const MOD = 1e9 + 7;

function waysToBuildRooms(prevRoom) {
    const n = prevRoom.length;
    const adj = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        adj[prevRoom[i]].push(i);
    }

    const fact = Array(n + 1).fill(1);
    const invFact = Array(n + 1).fill(1);
    for (let i = 1; i <= n; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
    }
    invFact[n] = modInverse(fact[n], MOD);
    for (let i = n - 1; i >= 0; i--) {
        invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
    }

    const dp = Array(n).fill(1);
    const size = Array(n).fill(1);

    function dfs(u) {
        for (const v of adj[u]) {
            dfs(v);
            size[u] += size[v];
            dp[u] = (dp[u] * dp[v]) % MOD;
            dp[u] = (dp[u] * invFact[size[v]]) % MOD;
        }
        dp[u] = (dp[u] * fact[size[u] - 1]) % MOD;
    }

    dfs(0);
    return dp[0];
}

function modInverse(a, mod) {
    let b = mod;
    let x = 0, y = 1, u = 1, v = 0;
    while (a !== 0) {
        const q = Math.floor(b / a);
        [a, b] = [b % a, a];
        [x, y] = [y - q * x, x];
        [u, v] = [v - q * u, u];
    }
    return (y + mod) % mod;
}