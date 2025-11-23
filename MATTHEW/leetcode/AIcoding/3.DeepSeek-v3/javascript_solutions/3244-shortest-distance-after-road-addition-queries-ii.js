class UnionFind {
    constructor(size) {
        this.parent = Array(size).fill().map((_, i) => i);
        this.rank = Array(size).fill(0);
    }

    find(u) {
        if (this.parent[u] !== u) {
            this.parent[u] = this.find(this.parent[u]);
        }
        return this.parent[u];
    }

    union(u, v) {
        const rootU = this.find(u);
        const rootV = this.find(v);
        if (rootU === rootV) return false;
        if (this.rank[rootU] > this.rank[rootV]) {
            this.parent[rootV] = rootU;
        } else if (this.rank[rootU] < this.rank[rootV]) {
            this.parent[rootU] = rootV;
        } else {
            this.parent[rootV] = rootU;
            this.rank[rootU]++;
        }
        return true;
    }
}

var shortestDistance = function(n, roads, queries) {
    const uf = new UnionFind(n);
    const adj = Array(n).fill().map(() => []);
    for (const [u, v] of roads) {
        adj[u].push(v);
        adj[v].push(u);
        uf.union(u, v);
    }

    const res = [];
    for (const [x, y] of queries) {
        if (uf.find(x) !== uf.find(y)) {
            res.push(-1);
            continue;
        }
        const queue = [[x, 0]];
        const visited = new Set([x]);
        let found = false;
        while (queue.length > 0 && !found) {
            const [current, dist] = queue.shift();
            if (current === y) {
                res.push(dist);
                found = true;
                break;
            }
            for (const neighbor of adj[current]) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push([neighbor, dist + 1]);
                }
            }
        }
    }
    return res;
};