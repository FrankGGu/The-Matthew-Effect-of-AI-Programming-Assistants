var areConnected = function(n, threshold, queries) {
    const parent = Array(n + 1).fill(0).map((_, i) => i);

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

    for (let i = threshold + 1; i <= n; i++) {
        for (let j = 2 * i; j <= n; j += i) {
            union(i, j);
        }
    }

    const result = [];
    for (const [a, b] of queries) {
        result.push(find(a) === find(b));
    }

    return result;
};