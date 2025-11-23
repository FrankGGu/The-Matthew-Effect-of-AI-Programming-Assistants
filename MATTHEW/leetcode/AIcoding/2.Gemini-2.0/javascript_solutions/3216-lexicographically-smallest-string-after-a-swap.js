var smallestStringWithSwaps = function(s, pairs) {
    const n = s.length;
    const parent = Array(n).fill(0).map((_, i) => i);

    function find(i) {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    function union(i, j) {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
        }
    }

    for (const [i, j] of pairs) {
        union(i, j);
    }

    const groups = {};
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!groups[root]) {
            groups[root] = [];
        }
        groups[root].push(i);
    }

    let result = Array(n);
    for (const root in groups) {
        const indices = groups[root].sort((a, b) => a - b);
        const chars = indices.map(i => s[i]).sort();
        for (let i = 0; i < indices.length; i++) {
            result[indices[i]] = chars[i];
        }
    }

    return result.join('');
};