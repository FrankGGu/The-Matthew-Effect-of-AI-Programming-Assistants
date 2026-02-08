var removeStones = function(stones) {
    const n = stones.length;
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

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (stones[i][0] === stones[j][0] || stones[i][1] === stones[j][1]) {
                union(i, j);
            }
        }
    }

    let components = 0;
    for (let i = 0; i < n; i++) {
        if (parent[i] === i) {
            components++;
        }
    }

    return n - components;
};