var smallestStringWithSwaps = function(s, pairs) {
    const n = s.length;
    const parent = new Array(n).fill(0).map((_, i) => i);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootV] = rootU;
        }
    }

    for (const [u, v] of pairs) {
        union(u, v);
    }

    const groups = new Map();
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!groups.has(root)) {
            groups.set(root, []);
        }
        groups.get(root).push(i);
    }

    const result = new Array(n);
    for (const [root, indices] of groups) {
        const chars = indices.map(i => s[i]).sort();
        indices.sort((a, b) => a - b);
        for (let i = 0; i < indices.length; i++) {
            result[indices[i]] = chars[i];
        }
    }

    return result.join('');
};