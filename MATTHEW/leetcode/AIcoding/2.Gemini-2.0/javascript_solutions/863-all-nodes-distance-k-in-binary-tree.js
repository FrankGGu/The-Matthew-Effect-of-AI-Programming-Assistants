var distanceK = function(root, target, k) {
    const adj = new Map();

    function buildGraph(node, parent) {
        if (!node) return;
        if (parent) {
            if (!adj.has(node)) adj.set(node, []);
            if (!adj.has(parent)) adj.set(parent, []);
            adj.get(node).push(parent);
            adj.get(parent).push(node);
        }
        buildGraph(node.left, node);
        buildGraph(node.right, node);
    }

    buildGraph(root, null);

    const queue = [target];
    const visited = new Set([target]);
    let dist = 0;

    while (queue.length > 0 && dist < k) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            const neighbors = adj.get(node) || [];
            for (const neighbor of neighbors) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push(neighbor);
                }
            }
        }
        dist++;
    }

    const result = [];
    while (queue.length > 0) {
        result.push(queue.shift().val);
    }

    return result;
};