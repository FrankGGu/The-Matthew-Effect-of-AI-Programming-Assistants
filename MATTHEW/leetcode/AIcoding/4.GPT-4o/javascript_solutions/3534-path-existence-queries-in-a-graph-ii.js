class Graph {
    constructor(n) {
        this.graph = Array.from({ length: n }, () => new Set());
    }

    addEdge(u, v) {
        this.graph[u].add(v);
        this.graph[v].add(u);
    }

    bfs(start, end, visited) {
        const queue = [start];
        visited[start] = true;

        while (queue.length) {
            const node = queue.shift();
            if (node === end) return true;

            for (const neighbor of this.graph[node]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.push(neighbor);
                }
            }
        }
        return false;
    }
}

var pathExists = function(n, edges, queries) {
    const graph = new Graph(n);
    for (const [u, v] of edges) {
        graph.addEdge(u, v);
    }

    const results = [];
    for (const [start, end] of queries) {
        const visited = new Array(n).fill(false);
        results.push(graph.bfs(start, end, visited));
    }

    return results;
};