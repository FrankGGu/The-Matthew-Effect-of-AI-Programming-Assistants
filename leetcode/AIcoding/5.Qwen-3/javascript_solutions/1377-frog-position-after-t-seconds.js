function frogPosition(root, t, target) {
    const graph = new Map();

    function buildGraph(node, parent) {
        if (!node) return;
        if (!graph.has(node.val)) graph.set(node.val, []);
        if (parent !== null) {
            graph.get(node.val).push(parent);
            graph.get(parent).push(node.val);
        }
        buildGraph(node.left, node.val);
        buildGraph(node.right, node.val);
    }

    buildGraph(root, null);

    const visited = new Set();
    const queue = [[root.val, 0, -1]]; // [position, time, parent]

    while (queue.length > 0) {
        const [pos, time, parent] = queue.shift();
        if (time === t) {
            return pos === target ? pos : -1;
        }
        visited.add(pos);
        let children = graph.get(pos);
        let count = 0;
        for (let child of children) {
            if (child !== parent && !visited.has(child)) {
                count++;
            }
        }
        if (count === 0) {
            return pos === target ? pos : -1;
        }
        for (let child of children) {
            if (child !== parent && !visited.has(child)) {
                queue.push([child, time + 1, pos]);
            }
        }
    }

    return -1;
}