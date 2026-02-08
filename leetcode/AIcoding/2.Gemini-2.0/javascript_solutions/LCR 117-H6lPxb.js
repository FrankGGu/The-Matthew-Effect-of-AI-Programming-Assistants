var numSimilarGroups = function(strs) {
    const n = strs.length;
    const parent = Array.from({ length: n }, (_, i) => i);

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