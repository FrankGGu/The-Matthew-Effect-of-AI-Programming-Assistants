class Graph {
    constructor(n) {
        this.adj = Array(n).fill(null).map(() => []);
    }

    addEdge(u, v, w) {
        this.adj[u].push([v, w]);
    }

    shortestPath(start, end) {
        const n = this.adj.length;
        const dist = Array(n).fill(Infinity);
        dist[start] = 0;
        const pq = [[0, start]];

        while (pq.length > 0) {
            pq.sort((a, b) => a[0] - b[0]);
            const [d, u] = pq.shift();

            if (d > dist[u]) continue;

            for (const [v, w] of this.adj[u]) {
                if (dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.push([dist[v], v]);
                }
            }
        }

        return dist[end] === Infinity ? -1 : dist[end];
    }
}

var Solution = function(n, edges) {
    this.graph = new Graph(n);
    for (const [u, v, w] of edges) {
        this.graph.addEdge(u, v, w);
    }
};

Solution.prototype.query = function(start, end) {
    return this.graph.shortestPath(start, end);
};