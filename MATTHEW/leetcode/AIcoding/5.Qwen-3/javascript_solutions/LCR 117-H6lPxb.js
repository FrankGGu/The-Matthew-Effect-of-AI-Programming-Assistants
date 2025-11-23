function numSimilarGroups(strs) {
    const n = strs.length;
    const parent = new Array(n).fill(0).map((_, i) => i);

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

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let diff = 0;
            for (let k = 0; k < strs[i].length && diff < 2; k++) {
                if (strs[i][k] !== strs[j][k]) {
                    diff++;
                }
            }
            if (diff < 2) {
                union(i, j);
            }
        }
    }

    const roots = new Set();
    for (let i = 0; i < n; i++) {
        roots.add(find(i));
    }
    return roots.size;
}