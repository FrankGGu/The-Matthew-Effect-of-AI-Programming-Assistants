function minimizeHammingDistance(source, target, allowedSwaps) {
    const n = source.length;
    const parent = Array.from({ length: n }, (_, i) => i);

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

    for (const [x, y] of allowedSwaps) {
        union(x, y);
    }

    const groups = {};
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!groups[root]) {
            groups[root] = { source: [], target: [] };
        }
        groups[root].source.push(source[i]);
        groups[root].target.push(target[i]);
    }

    let hammingDistance = 0;
    for (const group of Object.values(groups)) {
        const sourceCount = {};
        const targetCount = {};

        for (const s of group.source) {
            sourceCount[s] = (sourceCount[s] || 0) + 1;
        }
        for (const t of group.target) {
            targetCount[t] = (targetCount[t] || 0) + 1;
        }

        let matches = 0;
        for (const key in sourceCount) {
            if (targetCount[key]) {
                matches += Math.min(sourceCount[key], targetCount[key]);
            }
        }
        hammingDistance += group.source.length - matches;
    }

    return hammingDistance;
}