class DSU {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);
        if (rootI !== rootJ) {
            this.parent[rootI] = rootJ;
            return true;
        }
        return false;
    }
}

var distanceLimitedPathsExist = function(n, edgeList, queries) {
    const dsu = new DSU(n);

    for (let i = 0; i < queries.length; i++) {
        queries[i].push(i);
    }
    queries.sort((a, b) => a[2] - b[2]);

    edgeList.sort((a, b) => a[2] - b[2]);

    const ans = Array(queries.length);
    let edgeIdx = 0;

    for (const [u, v, limit, originalIdx] of queries) {
        while (edgeIdx < edgeList.length && edgeList[edgeIdx][2] < limit) {
            const [node1, node2] = edgeList[edgeIdx];
            dsu.union(node1, node2);
            edgeIdx++;
        }
        ans[originalIdx] = dsu.find(u) === dsu.find(v);
    }

    return ans;
};