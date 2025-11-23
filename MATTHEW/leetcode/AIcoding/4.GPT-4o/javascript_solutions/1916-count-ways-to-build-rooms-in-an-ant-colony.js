var countWays = function(prevRoom) {
    const MOD = 1e9 + 7;
    const n = prevRoom.length + 1;
    const graph = Array.from({ length: n }, () => []);

    for (let i = 0; i < prevRoom.length; i++) {
        graph[prevRoom[i]].push(i + 1);
    }

    const dfs = (node) => {
        let totalWays = 1;
        let size = 0;
        let childrenWays = 1;

        for (const child of graph[node]) {
            const [ways, subtreeSize] = dfs(child);
            totalWays = (totalWays * ways) % MOD;
            childrenWays = (childrenWays * factorial(subtreeSize)) % MOD;
            size += subtreeSize;
        }
        return [(totalWays * factorial(size) % MOD * modInverse(childrenWays, MOD)) % MOD, size + 1];
    };

    const factorial = (x) => {
        let res = 1;
        for (let i = 2; i <= x; i++) {
            res = (res * i) % MOD;
        }
        return res;
    };

    const modInverse = (a, mod) => {
        let m0 = mod, y = 0, x = 1;
        if (mod === 1) return 0;
        while (a > 1) {
            let q = Math.floor(a / mod);
            [mod, a] = [a % mod, mod];
            [y, x] = [x - q * y, y];
        }
        return x < 0 ? x + m0 : x;
    };

    return dfs(0)[0];
};