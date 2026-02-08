class Graph {
    constructor(n) {
        this.adj = Array.from({ length: n }, () => []);
    }

    addEdge(u, v) {
        this.adj[u].push(v);
        this.adj[v].push(u);
    }

    dfs(start, end, visited) {
        if (start === end) return true;
        visited[start] = true;
        for (const neighbor of this.adj[start]) {
            if (!visited[neighbor] && this.dfs(neighbor, end, visited)) {
                return true;
            }
        }
        return false;
    }

    pathExists(start, end) {
        const visited = Array(this.adj.length).fill(false);
        return this.dfs(start, end, visited);
    }
}

var checkPaths = function(n, edges, queries) {
    const graph = new Graph(n);
    for (const [u, v] of edges) {
        graph.addEdge(u, v);
    }
    const result = [];
    for (const [start, end] of queries) {
        result.push(graph.pathExists(start, end));
    }
    return result;
};