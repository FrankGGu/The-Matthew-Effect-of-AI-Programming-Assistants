class Graph {
    constructor() {
        this.adjacencyList = new Map();
    }

    addEdge(start, end, value) {
        if (!this.adjacencyList.has(start)) this.adjacencyList.set(start, []);
        if (!this.adjacencyList.has(end)) this.adjacencyList.set(end, []);
        this.adjacencyList.get(start).push({ node: end, value });
        this.adjacencyList.get(end).push({ node: start, value: 1 / value });
    }

    bfs(start, end) {
        const queue = [[start, 1]];
        const visited = new Set([start]);

        while (queue.length > 0) {
            const [node, value] = queue.shift();
            if (node === end) return value;

            for (const neighbor of this.adjacencyList.get(node) || []) {
                if (!visited.has(neighbor.node)) {
                    visited.add(neighbor.node);
                    queue.push([neighbor.node, value * neighbor.value]);
                }
            }
        }
        return -1;
    }
}

var calcEquation = function(equations, values, queries) {
    const graph = new Graph();

    for (let i = 0; i < equations.length; i++) {
        graph.addEdge(equations[i][0], equations[i][1], values[i]);
    }

    const results = [];
    for (const [start, end] of queries) {
        if (!graph.adjacencyList.has(start) || !graph.adjacencyList.has(end)) {
            results.push(-1);
        } else {
            results.push(graph.bfs(start, end));
        }
    }
    return results;
};