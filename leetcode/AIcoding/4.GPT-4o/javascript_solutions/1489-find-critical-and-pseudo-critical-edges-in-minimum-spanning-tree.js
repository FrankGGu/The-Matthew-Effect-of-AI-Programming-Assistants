class UnionFind {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.rank = Array(n).fill(0);
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        const rootX = this.find(x);
        const rootY = this.find(y);
        if (rootX !== rootY) {
            if (this.rank[rootX] > this.rank[rootY]) {
                this.parent[rootY] = rootX;
            } else if (this.rank[rootX] < this.rank[rootY]) {
                this.parent[rootX] = rootY;
            } else {
                this.parent[rootY] = rootX;
                this.rank[rootX]++;
            }
            return true;
        }
        return false;
    }
}

function findCriticalAndPseudoCriticalEdges(n, edges) {
    edges = edges.map((edge, index) => [...edge, index]);
    edges.sort((a, b) => a[2] - b[2]);

    const kruskal = (n, edges, skipIndex, includeIndex) => {
        const uf = new UnionFind(n);
        let totalWeight = 0;
        if (includeIndex !== -1) {
            const [u, v, weight] = edges[includeIndex];
            uf.union(u, v);
            totalWeight += weight;
        }
        for (let i = 0; i < edges.length; i++) {
            if (i === skipIndex) continue;
            const [u, v, weight] = edges[i];
            if (uf.union(u, v)) {
                totalWeight += weight;
            }
        }
        return uf.rank.reduce((count, rank) => count + (rank > 0 ? 1 : 0), 0) === n - 1 ? totalWeight : Infinity;
    };

    const minWeight = kruskal(n, edges, -1, -1);
    const criticalEdges = [];
    const pseudoCriticalEdges = [];

    for (let i = 0; i < edges.length; i++) {
        const weightWithoutI = kruskal(n, edges, i, -1);
        if (weightWithoutI > minWeight) {
            criticalEdges.push(edges[i][3]);
        } else {
            const weightWithI = kruskal(n, edges, -1, i);
            if (weightWithI === minWeight) {
                pseudoCriticalEdges.push(edges[i][3]);
            }
        }
    }

    return [criticalEdges, pseudoCriticalEdges];
}