class Graph {
    constructor(n, edges) {
        this.n = n;
        this.adj = new Array(n).fill(null).map(() => new Map());

        for (const [from, to, cost] of edges) {
            this.addEdge([from, to, cost]);
        }
    }

    addEdge(edge) {
        const [from, to, cost] = edge;
        this.adj[from].set(to, cost);
    }

    shortestPath(node1, node2) {
        const dist = new Array(this.n).fill(Infinity);
        dist[node1] = 0;

        const visited = new Array(this.n).fill(false);

        for (let i = 0; i < this.n; i++) {
            let u = -1;
            let minDist = Infinity;

            for (let v = 0; v < this.n; v++) {
                if (!visited[v] && dist[v] < minDist) {
                    minDist = dist[v];
                    u = v;
                }
            }

            if (u === -1) {
                break;
            }

            visited[u] = true;

            for (const [v, weight] of this.adj[u].entries()) {
                if (!visited[v] && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                }
            }
        }

        return dist[node2] === Infinity ? -1 : dist[node2];
    }
}