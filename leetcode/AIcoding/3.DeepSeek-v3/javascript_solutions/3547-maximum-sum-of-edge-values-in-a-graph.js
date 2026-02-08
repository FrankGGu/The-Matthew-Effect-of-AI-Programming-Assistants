var maxSum = function(n, edges) {
    const parent = Array(n).fill().map((_, i) => i);
    const rank = Array(n).fill(0);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) return false;
        if (rank[rootU] > rank[rootV]) {
            parent[rootV] = rootU;
        } else if (rank[rootU] < rank[rootV]) {
            parent[rootU] = rootV;
        } else {
            parent[rootV] = rootU;
            rank[rootU]++;
        }
        return true;
    }

    edges.sort((a, b) => b[2] - a[2]);
    let res = 0;
    for (const [u, v, w] of edges) {
        if (union(u, v)) {
            res += w;
        }
    }

    const root = find(0);
    for (let i = 1; i < n; i++) {
        if (find(i) !== root) {
            return -1;
        }
    }
    return res;
};