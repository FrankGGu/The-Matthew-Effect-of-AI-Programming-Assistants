var waysToBuildRooms = function(prevRoom) {
    const n = prevRoom.length;
    const MOD = 10**9 + 7;
    const children = Array(n).fill(null).map(() => []);
    for (let i = 1; i < n; i++) {
        children[prevRoom[i]].push(i);
    }

    const sizes = Array(n).fill(0);
    function dfs(node) {
        sizes[node] = 1;
        for (const child of children[node]) {
            dfs(child);
            sizes[node] += sizes[child];
        }
    }

    dfs(0);

    let factorial = Array(n + 1).fill(1);
    for (let i = 2; i <= n; i++) {
        factorial[i] = (factorial[i - 1] * i) % MOD;
    }

    function power(base, exp) {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    }

    function modInverse(n) {
        return power(n, MOD - 2);
    }

    let result = factorial[n - 1];
    for (let i = 0; i < n; i++) {
        result = (result * modInverse(factorial[sizes[i] - 1])) % MOD;
    }

    return result;
};