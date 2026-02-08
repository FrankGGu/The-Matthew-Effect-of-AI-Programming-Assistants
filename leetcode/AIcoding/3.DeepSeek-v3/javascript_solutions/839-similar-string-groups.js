var numSimilarGroups = function(strs) {
    const n = strs.length;
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

    function isSimilar(a, b) {
        let diff = 0;
        for (let i = 0; i < a.length; i++) {
            if (a[i] !== b[i]) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return diff === 0 || diff === 2;
    }

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (isSimilar(strs[i], strs[j])) {
                union(i, j);
            }
        }
    }

    let groups = 0;
    for (let i = 0; i < n; i++) {
        if (parent[i] === i) {
            groups++;
        }
    }

    return groups;
};