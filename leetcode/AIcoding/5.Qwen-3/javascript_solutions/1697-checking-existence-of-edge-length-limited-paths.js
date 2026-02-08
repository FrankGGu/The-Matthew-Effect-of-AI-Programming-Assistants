function distanceLimitedPathsExist(n, edgeList, queries) {
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
            parent[rootY] = rootX;
        }
    }

    edgeList.sort((a, b) => a[2] - b[2]);

    const sortedQueries = queries.map((q, i) => [q[0], q[1], q[2], i]).sort((a, b) => a[2] - b[2]);

    const result = Array(queries.length).fill(false);

    let edgeIndex = 0;

    for (const [u, v, limit, idx] of sortedQueries) {
        while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
            union(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
            edgeIndex++;
        }
        if (find(u) === find(v)) {
            result[idx] = true;
        }
    }

    return result;
}