var findMinHeightTrees = function(n, edges) {
    if (n <= 2) {
        return Array.from({ length: n }, (_, i) => i);
    }

    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let leaves = [];
    for (let i = 0; i < n; i++) {
        if (adj[i].length === 1) {
            leaves.push(i);
        }
    }

    let remainingNodes = n;
    while (remainingNodes > 2) {
        remainingNodes -= leaves.length;
        const newLeaves = [];
        for (const leaf of leaves) {
            const neighbor = adj[leaf][0];
            adj[neighbor].splice(adj[neighbor].indexOf(leaf), 1);
            if (adj[neighbor].length === 1) {
                newLeaves.push(neighbor);
            }
        }
        leaves = newLeaves;
    }

    return leaves;
};

var solve = function(root1, root2) {
    const buildGraph = (root) => {
        const nodes = [];
        const edges = [];
        const queue = [root];
        const nodeMap = new Map();
        let nodeCount = 0;

        while (queue.length > 0) {
            const node = queue.shift();
            if (!nodeMap.has(node)) {
                nodeMap.set(node, nodeCount++);
                nodes.push(node);
            }

            if (node.left) {
                if (!nodeMap.has(node.left)) {
                    nodeMap.set(node.left, nodeCount++);
                    nodes.push(node.left);
                }
                edges.push([nodeMap.get(node), nodeMap.get(node.left)]);
                queue.push(node.left);
            }

            if (node.right) {
                if (!nodeMap.has(node.right)) {
                    nodeMap.set(node.right, nodeCount++);
                    nodes.push(node.right);
                }
                edges.push([nodeMap.get(node), nodeMap.get(node.right)]);
                queue.push(node.right);
            }
        }

        return { nodes, edges, nodeMap };
    };

    const { nodes: nodes1, edges: edges1, nodeMap: nodeMap1 } = buildGraph(root1);
    const { nodes: nodes2, edges: edges2, nodeMap: nodeMap2 } = buildGraph(root2);

    const n1 = nodes1.length;
    const n2 = nodes2.length;
    const n = n1 + n2;

    const edges = [...edges1.map(([u, v]) => [u, v]), ...edges2.map(([u, v]) => [u + n1, v + n1])];

    let minDiameter = Infinity;

    for (let i = 0; i < n1; i++) {
        edges.push([i, n1]);

        const adj = Array(n).fill(null).map(() => []);
        for (const [u, v] of edges) {
            adj[u].push(v);
            adj[v].push(u);
        }

        const bfs = (start) => {
            const dist = Array(n).fill(Infinity);
            dist[start] = 0;
            const queue = [start];

            while (queue.length > 0) {
                const u = queue.shift();
                for (const v of adj[u]) {
                    if (dist[v] === Infinity) {
                        dist[v] = dist[u] + 1;
                        queue.push(v);
                    }
                }
            }
            return dist;
        };

        let maxDist = 0;
        for (let j = 0; j < n; j++) {
            const dist = bfs(j);
            maxDist = Math.max(maxDist, ...dist);
        }

        minDiameter = Math.min(minDiameter, maxDist);
        edges.pop();
    }

    return minDiameter;
};

var findMinDiameter = function(root1, root2) {
    return solve(root1, root2);
};