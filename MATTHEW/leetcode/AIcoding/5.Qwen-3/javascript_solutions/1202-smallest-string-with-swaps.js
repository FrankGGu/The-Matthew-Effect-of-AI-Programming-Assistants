function smallestStringWithSwaps(s, pairs) {
    const parent = {};

    function find(x) {
        if (!parent[x]) parent[x] = x;
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

    for (const [u, v] of pairs) {
        union(u, v);
    }

    const groups = {};

    for (let i = 0; i < s.length; i++) {
        const root = find(i);
        if (!groups[root]) groups[root] = [];
        groups[root].push(i);
    }

    const result = s.split('');

    for (const group of Object.values(groups)) {
        const indices = group;
        const chars = indices.map(i => s[i]).sort();
        indices.sort((a, b) => a - b);
        for (let i = 0; i < indices.length; i++) {
            result[indices[i]] = chars[i];
        }
    }

    return result.join('');
}