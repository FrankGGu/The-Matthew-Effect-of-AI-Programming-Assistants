function minMaxEdge(n, edges, queryAnswer) {
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

    function isSameSet(x, y) {
        return find(x) === find(y);
    }

    for (let i = 0; i < queryAnswer.length; i++) {
        const [u, v, limit] = queryAnswer[i];
        for (let j = 0; j < edges.length; j++) {
            const [a, b, w] = edges[j];
            if (w <= limit) {
                union(a, b);
            }
        }
        if (!isSameSet(u, v)) {
            return i;
        }
    }

    return -1;
}