var cloneGraph = function(graph) {
    if (!graph) return null;

    const visited = new Map();
    const queue = [graph];
    const clonedGraph = new UndirectedGraphNode(graph.label);
    visited.set(graph, clonedGraph);

    while (queue.length > 0) {
        const node = queue.shift();
        const clonedNode = visited.get(node);

        for (const neighbor of node.neighbors) {
            if (!visited.has(neighbor)) {
                const clonedNeighbor = new UndirectedGraphNode(neighbor.label);
                visited.set(neighbor, clonedNeighbor);
                queue.push(neighbor);
            }
            clonedNode.neighbors.push(visited.get(neighbor));
        }
    }

    return clonedGraph;
};