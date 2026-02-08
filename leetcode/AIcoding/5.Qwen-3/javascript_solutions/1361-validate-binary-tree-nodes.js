function validateBinaryTreeNodes(root, nodes, edges) {
    const graph = new Map();
    for (let i = 0; i < nodes; i++) {
        graph.set(i, []);
    }

    for (const [parent, child] of edges) {
        if (graph.get(child).length > 0) {
            return false;
        }
        graph.get(parent).push(child);
    }

    const visited = new Set();
    const queue = [root];
    visited.add(root);

    while (queue.length > 0) {
        const node = queue.shift();
        for (const child of graph.get(node)) {
            if (visited.has(child)) {
                return false;
            }
            visited.add(child);
            queue.push(child);
        }
    }

    return visited.size === nodes;
}