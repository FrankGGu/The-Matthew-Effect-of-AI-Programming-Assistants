var numSimilarGroups = function(strs) {
    const n = strs.length;
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

    function isSimilar(str1, str2) {
        let diff = 0;
        for (let i = 0; i < str1.length; i++) {
            if (str1[i] !== str2[i]) {
                diff++;
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

    let count = 0;
    for (let i = 0; i < n; i++) {
        if (parent[i] === i) {
            count++;
        }
    }

    return count;
};