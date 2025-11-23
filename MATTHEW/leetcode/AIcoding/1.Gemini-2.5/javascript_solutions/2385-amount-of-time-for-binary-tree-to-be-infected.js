var amountOfTime = function(root, start) {
    const graph = new Map();

    function buildGraph(node, parentVal) {
        if (!node) return;

        if (!graph.has(node.val)) {
            graph.set(node.val, new Set());
        }

        if (parentVal !== null) {
            graph.get(node.val).add(parentVal);
            if (!graph.has(parentVal)) {
                graph.set(parentVal, new Set());
            }
            graph.get(parentVal).add(node.val);
        }

        buildGraph(node.left, node.val);
        buildGraph(node.right, node.val);
    }

    buildGraph(root, null);

    let maxTime = 0;
    const queue = [[start, 0]];
    const visited = new Set();
    visited.add(start);

    while (queue.length > 0) {
        const [currentNodeVal, currentTime] = queue.shift();
        maxTime = Math.max(maxTime, currentTime);

        const neighbors = graph.get(currentNodeVal);
        if (neighbors) {
            for (const neighborVal of neighbors) {
                if (!visited.has(neighborVal)) {
                    visited.add(neighborVal);
                    queue.push([neighborVal, currentTime + 1]);
                }
            }
        }
    }

    return maxTime;
};