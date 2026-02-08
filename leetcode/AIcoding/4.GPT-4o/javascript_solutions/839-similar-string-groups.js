var numSimilarGroups = function(A) {
    const find = (parent, x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    };

    const union = (parent, x, y) => {
        const rootX = find(parent, x);
        const rootY = find(parent, y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    };

    const areSimilar = (str1, str2) => {
        let diff = 0;
        for (let i = 0; i < str1.length; i++) {
            if (str1[i] !== str2[i]) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return diff === 0 || diff === 2;
    };

    const n = A.length;
    const parent = Array.from({ length: n }, (_, index) => index);

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (areSimilar(A[i], A[j])) {
                union(parent, i, j);
            }
        }
    }

    const groups = new Set();
    for (let i = 0; i < n; i++) {
        groups.add(find(parent, i));
    }

    return groups.size;
};