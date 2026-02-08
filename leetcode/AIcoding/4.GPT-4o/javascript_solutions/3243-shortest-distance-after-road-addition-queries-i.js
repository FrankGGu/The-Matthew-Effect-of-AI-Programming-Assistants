class UnionFind {
    constructor(n) {
        this.parent = Array.from({length: n}, (_, i) => i);
        this.rank = Array(n).fill(1);
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        let rootX = this.find(x);
        let rootY = this.find(y);
        if (rootX !== rootY) {
            if (this.rank[rootX] > this.rank[rootY]) {
                this.parent[rootY] = rootX;
            } else if (this.rank[rootX] < this.rank[rootY]) {
                this.parent[rootX] = rootY;
            } else {
                this.parent[rootY] = rootX;
                this.rank[rootX]++;
            }
        }
    }
}

var shortestDistance = function(n, roads, queries) {
    const uf = new UnionFind(n);
    const graph = Array.from({length: n}, () => []);
    const dist = Array(n).fill(Infinity);

    for (const [u, v, w] of roads) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
        uf.union(u, v);
    }

    const results = [];
    for (const [src, dst, limit] of queries) {
        if (uf.find(src) !== uf.find(dst)) {
            results.push(-1);
            continue;
        }

        dist.fill(Infinity);
        const pq = [[0, src]];
        dist[src] = 0;

        while (pq.length) {
            const [d, node] = pq.shift();
            if (d > dist[node]) continue;
            for (const [neighbor, weight] of graph[node]) {
                if (d + weight < dist[neighbor] && d + weight <= limit) {
                    dist[neighbor] = d + weight;
                    pq.push([dist[neighbor], neighbor]);
                    pq.sort((a, b) => a[0] - b[0]);
                }
            }
        }

        results.push(dist[dst] === Infinity ? -1 : dist[dst]);
    }

    return results;
};