var findCriticalAndPseudoCriticalEdges = function(n, edges) {
    const m = edges.length;
    for (let i = 0; i < m; i++) {
        edges[i].push(i);
    }
    edges.sort((a, b) => a[2] - b[2]);

    const uf_std = new UnionFind(n);
    let std = 0;
    for (const [u, v, w, _] of edges) {
        if (uf_std.union(u, v)) {
            std += w;
        }
    }

    const critical = [];
    const pseudo = [];

    for (let i = 0; i < m; i++) {
        const uf = new UnionFind(n);
        let cost = 0;
        for (let j = 0; j < m; j++) {
            if (i === j) continue;
            const [u, v, w, _] = edges[j];
            if (uf.union(u, v)) {
                cost += w;
            }
        }
        if (uf.count !== 1 || cost > std) {
            critical.push(edges[i][3]);
            continue;
        }

        const uf_force = new UnionFind(n);
        const [u, v, w, idx] = edges[i];
        uf_force.union(u, v);
        cost = w;
        for (let j = 0; j < m; j++) {
            if (i === j) continue;
            const [u1, v1, w1, _] = edges[j];
            if (uf_force.union(u1, v1)) {
                cost += w1;
            }
        }
        if (cost === std) {
            pseudo.push(idx);
        }
    }

    const criticalSet = new Set(critical);
    const pseudoSet = new Set();
    for (const idx of pseudo) {
        if (!criticalSet.has(idx)) {
            pseudoSet.add(idx);
        }
    }

    return [Array.from(criticalSet), Array.from(pseudoSet)];
};

class UnionFind {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
        this.count = n;
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
        if (rootX === rootY) return false;
        this.parent[rootX] = rootY;
        this.count--;
        return true;
    }
}