var amountOfTime = function(root, start) {
    let graph = new Map();

    function buildGraph(node, parent) {
        if (!node) return;

        if (!graph.has(node.val)) {
            graph.set(node.val, []);
        }

        if (parent !== null) {
            graph.get(node.val).push(parent.val);
        }

        if (node.left) {
            if (!graph.has(node.left.val)) {
                graph.set(node.left.val, []);
            }
            graph.get(node.val).push(node.left.val);
            graph.get(node.left.val).push(node.val);
        }

        if (node.right) {
            if (!graph.has(node.right.val)) {
                graph.set(node.right.val, []);
            }
            graph.get(node.val).push(node.right.val);
            graph.get(node.right.val).push(node.val);
        }

        buildGraph(node.left, node);
        buildGraph(node.right, node);
    }

    buildGraph(root, null);

    let queue = [start];
    let visited = new Set();
    visited.add(start);
    let time = 0;

    while (queue.length > 0) {
        let size = queue.length;
        for (let i = 0; i < size; i++) {
            let node = queue.shift();

            let neighbors = graph.get(node);
            if (neighbors) {
                for (let neighbor of neighbors) {
                    if (!visited.has(neighbor)) {
                        queue.push(neighbor);
                        visited.add(neighbor);
                    }
                }
            }
        }
        if (queue.length > 0) {
            time++;
        }
    }

    return time;
};