class UnionFind {
    constructor(n) {
        this.parent = new Array(n + 1).fill(0).map((_, i) => i);
        this.count = n;
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            this.parent[rootI] = rootJ;
            this.count--;
            return true;
        }
        return false;
    }
}

var maxNumEdgesToRemove = function(n, edges) {
    const ufAlice = new UnionFind(n);
    const ufBob = new UnionFind(n);

    let edgesUsed = 0;

    const type3Edges = [];
    const type1Edges = [];
    const type2Edges = [];

    for (const edge of edges) {
        if (edge[0] === 3) {
            type3Edges.push(edge);
        } else if (edge[0] === 1) {
            type1Edges.push(edge);
        } else {
            type2Edges.push(edge);
        }
    }

    for (const [type, u, v] of type3Edges) {
        const mergedForAlice = ufAlice.union(u, v);
        const mergedForBob = ufBob.union(u, v);

        if (mergedForAlice || mergedForBob) {
            edgesUsed++;
        }
    }

    for (const [type, u, v] of type1Edges) {
        if (ufAlice.union(u, v)) {
            edgesUsed++;
        }
    }

    for (const [type, u, v] of type2Edges) {
        if (ufBob.union(u, v)) {
            edgesUsed++;
        }
    }

    if (ufAlice.count !== 1 || ufBob.count !== 1) {
        return -1;
    }

    return edges.length - edgesUsed;
};