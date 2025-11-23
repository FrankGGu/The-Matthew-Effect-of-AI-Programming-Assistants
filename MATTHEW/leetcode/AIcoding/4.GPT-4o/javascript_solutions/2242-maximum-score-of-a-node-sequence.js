class Graph {
    constructor(n) {
        this.graph = Array.from({ length: n }, () => []);
    }

    addEdge(u, v) {
        this.graph[u].push(v);
        this.graph[v].push(u);
    }

    getNeighbors(node) {
        return this.graph[node];
    }
}

var maximumScore = function(scores, edges) {
    const n = scores.length;
    const graph = new Graph(n);

    for (const [u, v] of edges) {
        graph.addEdge(u, v);
    }

    let maxScore = -1;

    for (let i = 0; i < n; i++) {
        const neighbors = graph.getNeighbors(i);
        const numNeighbors = neighbors.length;

        if (numNeighbors < 2) continue;

        for (let j = 0; j < numNeighbors; j++) {
            for (let k = j + 1; k < numNeighbors; k++) {
                const u = neighbors[j];
                const v = neighbors[k];

                if (graph.getNeighbors(u).includes(v) || graph.getNeighbors(v).includes(u)) continue;

                const totalScore = scores[i] + scores[u] + scores[v];
                maxScore = Math.max(maxScore, totalScore);
            }
        }
    }

    return maxScore;
};