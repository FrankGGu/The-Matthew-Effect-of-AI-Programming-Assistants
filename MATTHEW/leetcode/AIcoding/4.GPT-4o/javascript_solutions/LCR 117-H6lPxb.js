var numSimilarGroups = function(strs) {
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

    const areSimilar = (s1, s2) => {
        let diff = 0;
        for (let i = 0; i < s1.length; i++) {
            if (s1[i] !== s2[i]) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return diff === 0 || diff === 2;
    };

    const n = strs.length;
    parent = Array.from({ length: n }, (_, i) => i);

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (areSimilar(strs[i], strs[j])) {
                union(i, j);
            }
        }
    }

    const groups = new Set();
    for (let i = 0; i < n; i++) {
        groups.add(find(i));
    }

    return groups.size;
};