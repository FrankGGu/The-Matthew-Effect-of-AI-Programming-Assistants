var smallestStringWithSwaps = function(s, pairs) {
    const parent = Array.from({ length: s.length }, (_, i) => i);

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    };

    for (const [u, v] of pairs) {
        union(u, v);
    }

    const groups = {};
    for (let i = 0; i < s.length; i++) {
        const root = find(i);
        if (!groups[root]) {
            groups[root] = [];
        }
        groups[root].push(i);
    }

    const result = Array.from(s);
    for (const indices of Object.values(groups)) {
        const chars = indices.map(i => s[i]).sort();
        indices.sort((a, b) => a - b);
        for (let i = 0; i < indices.length; i++) {
            result[indices[i]] = chars[i];
        }
    }

    return result.join('');
};