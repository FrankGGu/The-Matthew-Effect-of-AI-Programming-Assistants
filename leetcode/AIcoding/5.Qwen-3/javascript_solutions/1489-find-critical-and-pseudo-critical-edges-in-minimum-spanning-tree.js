function findCriticalAndPseudoCriticalEdges(n, edges) {
    const mst = (n, edges, includeEdge = -1, excludeEdge = -1) => {
        let totalWeight = 0;
        let parent = Array.from({ length: n }, (_, i) => i);

        const find = (x) => {
            if (parent[x] !== x) parent[x] = find(parent[x]);
            return parent[x];
        };

        const union = (x, y) => {
            const rootX = find(x);
            const rootY = find(y);
            if (rootX === rootY) return false;
            parent[rootY] = rootX;
            return true;
        };

        if (includeEdge !== -1) {
            const [u, v, w] = edges[includeEdge];
            if (union(u, v)) totalWeight += w;
        }

        for (let i = 0; i < edges.length; i++) {
            if (i === excludeEdge) continue;
            const [u, v, w] = edges[i];
            if (union(u, v)) totalWeight += w;
        }

        const root = find(0);
        for (let i = 1; i < n; i++) {
            if (find(i) !== root) return Infinity;
        }

        return totalWeight;
    };

    const originalMST = mst(n, edges);
    const critical = [];
    const pseudoCritical = [];

    for (let i = 0; i < edges.length; i++) {
        const weightWithout = mst(n, edges, -1, i);
        if (weightWithout > originalMST) {
            critical.push(i);
        } else {
            const weightWith = mst(n, edges, i, -1);
            if (weightWith === originalMST) {
                pseudoCritical.push(i);
            }
        }
    }

    return [critical, pseudoCritical];
}