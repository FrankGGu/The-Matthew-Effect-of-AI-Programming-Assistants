function minimizeHammingDistance(s, pairs) {
    const n = s.length;
    const parent = Array(n).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
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
        groups.get(root).push(s[i]);
    }

    for (const group of groups.values()) {
        group.sort();
    }

    const result = Array(n);
    for (let i = 0; i < n; i++) {
        const root = find(i);
        const chars = groups.get(root);
        result[i] = chars.shift();
    }

    return result.join('');
}