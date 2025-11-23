var countWays = function(n, edges) {
    const MOD = 1e9 + 7;
    const parent = new Array(n).fill(-1);

    function find(u) {
        if (parent[u] === -1) return u;
        return find(parent[u]);
    }

    let result = 1;
    for (const [u, v] of edges) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootV] = rootU;
        } else {
            result = (result * 2) % MOD;
        }
    }

    return result;
};