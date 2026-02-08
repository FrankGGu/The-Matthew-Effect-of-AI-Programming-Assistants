class TreeNode {
    constructor(val) {
        this.val = val;
        this.children = [];
    }
}

function shortestPath(root, start, end) {
    const graph = new Map();

    function buildGraph(node) {
        for (const child of node.children) {
            graph.set(`${node.val}-${child.val}`, child.weight);
            graph.set(`${child.val}-${node.val}`, child.weight);
            buildGraph(child);
        }
    }

    buildGraph(root);

    const pq = new MinPriorityQueue();
    const dist = new Map();
    pq.enqueue(start, 0);
    dist.set(start, 0);

    while (!pq.isEmpty()) {
        const { element: u } = pq.dequeue();
        if (u === end) return dist.get(u);

        for (const [key, weight] of graph.entries()) {
            const [from, to] = key.split('-').map(Number);
            if (from === u) {
                const alt = dist.get(u) + weight;
                if (alt < (dist.get(to) || Infinity)) {
                    dist.set(to, alt);
                    pq.enqueue(to, alt);
                }
            }
        }
    }

    return -1;
}