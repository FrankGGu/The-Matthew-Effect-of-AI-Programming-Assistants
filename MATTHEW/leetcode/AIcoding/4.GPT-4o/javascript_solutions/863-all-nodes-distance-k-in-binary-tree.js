var distanceK = function(root, target, K) {
    const graph = new Map();

    const buildGraph = (node, parent) => {
        if (!node) return;
        if (!graph.has(node)) graph.set(node, []);
        if (parent) {
            graph.get(node).push(parent);
            graph.get(parent).push(node);
        }
        buildGraph(node.left, node);
        buildGraph(node.right, node);
    };

    buildGraph(root, null);

    const result = [];
    const visited = new Set();
    const queue = [[target, 0]];

    while (queue.length) {
        const [node, distance] = queue.shift();
        if (visited.has(node)) continue;
        visited.add(node);
        if (distance === K) result.push(node.val);
        if (distance < K) {
            for (const neighbor of graph.get(node)) {
                queue.push([neighbor, distance + 1]);
            }
        }
    }

    return result;
};