var smallestStringWithSwaps = function(s, pairs) {
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
            parent[rootX] = rootY;
        }
    }

    for (const [x, y] of pairs) {
        union(x, y);
    }

    const components = {};
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!components[root]) {
            components[root] = [];
        }
        components[root].push(i);
    }

    const result = Array(n).fill('');
    for (const root in components) {
        const indices = components[root].sort((a, b) => a - b);
        const chars = indices.map(i => s[i]).sort();
        for (let i = 0; i < indices.length; i++) {
            result[indices[i]] = chars[i];
        }
    }

    return result.join('');
};