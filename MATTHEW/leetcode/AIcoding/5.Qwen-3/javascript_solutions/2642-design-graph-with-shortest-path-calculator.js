var Graph = function(n, edges) {
    this.adj = new Array(n).fill().map(() => []);
    for (const [u, v, w] of edges) {
        this.adj[u].push([v, w]);
    }
};

Graph.prototype.addEdge = function(edge) {
    const [u, v, w] = edge;
    this.adj[u].push([v, w]);
};

Graph.prototype.shortestPath = function(node1, node2) {
    const dist = new Array(this.adj.length).fill(Infinity);
    dist[node1] = 0;
    const heap = [[0, node1]];

    while (heap.length > 0) {
        const [d, u] = heap.shift();
        if (d > dist[u]) continue;
        for (const [v, w] of this.adj[u]) {
            if (dist[v] > d + w) {
                dist[v] = d + w;
                heap.push([dist[v], v]);
                heap.sort((a, b) => a[0] - b[0]);
            }
        }
    }

    return dist[node2] === Infinity ? -1 : dist[node2];
};