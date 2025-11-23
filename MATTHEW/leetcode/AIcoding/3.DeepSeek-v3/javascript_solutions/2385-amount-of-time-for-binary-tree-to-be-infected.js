var amountOfTime = function(root, start) {
    const graph = new Map();
    buildGraph(root, null, graph);

    const visited = new Set();
    const queue = [[start, 0]];
    visited.add(start);
    let maxTime = 0;

    while (queue.length > 0) {
        const [currentNode, time] = queue.shift();
        maxTime = Math.max(maxTime, time);

        const neighbors = graph.get(currentNode) || [];
        for (const neighbor of neighbors) {
            if (!visited.has(neighbor)) {
                visited.add(neighbor);
                queue.push([neighbor, time + 1]);
            }
        }
    }

    return maxTime;
};

function buildGraph(node, parent, graph) {
    if (!node) return;

    if (!graph.has(node.val)) {
        graph.set(node.val, []);
    }

    if (parent !== null) {
        graph.get(node.val).push(parent.val);
        graph.get(parent.val).push(node.val);
    }

    buildGraph(node.left, node, graph);
    buildGraph(node.right, node, graph);
}