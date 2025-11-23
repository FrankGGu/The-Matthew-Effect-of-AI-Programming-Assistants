function buildAdj(n, edges) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }
    return adj;
}

function bfs(startNode, n, adj) {
    const dist = Array(n).fill(-1);
    const queue = [];

    queue.push(startNode);
    dist[startNode] = 0;

    let farthestNode = startNode;
    let maxDist = 0;

    let head = 0;
    while (head < queue.length) {
        const u = queue[head++];
        if (dist[u] > maxDist) {
            maxDist = dist[u];
            farthestNode = u;
        }

        for (const v of adj[u]) {
            if (dist[v] === -1) {
                dist[v] = dist[u] + 1;
                queue.push(v);
            }
        }
    }
    return { dist, farthestNode, maxDist };
}

var getMinDiameter = function(n1, edges1, n2, edges2) {
    const adj1 = buildAdj(n1, edges1);
    const adj2 = buildAdj(n2, edges2);

    // Calculate max_depth_from_node for tree1 and its diameter
    // maxDepth1[i] stores the maximum distance from node i to any other node in tree1
    let maxDepth1 = Array(n1).fill(0);
    let diameter1 = 0;
    if (n1 > 1) {
        // Find one endpoint of the diameter (A) by BFS from an arbitrary node (0)
        const { farthestNode: A, dist: distA } = bfs(0, n1, adj1);
        // Find the other endpoint of the diameter (B) and the diameter length (D1) by BFS from A
        const { farthestNode: B, maxDist: D1 } = bfs(A, n1, adj1);
        diameter1 = D1;

        // Calculate distances from B to all nodes
        const { dist: distB_all } = bfs(B, n1, adj1);
        // For each node i, maxDepth1[i] is max(distance from i to A, distance from i to B)
        for (let i = 0; i < n1; i++) {
            maxDepth1[i] = Math.max(distA[i], distB_all[i]);
        }
    }

    // Calculate max_depth_from_node for tree2 and its diameter
    let maxDepth2 = Array(n2).fill(0);
    let diameter2 = 0;
    if (n2 > 1) {
        const { farthestNode: A, dist: distA } = bfs(0, n2, adj2);
        const { farthestNode: B, maxDist: D2 } = bfs(A, n2, adj2);
        diameter2 = D2;

        const { dist: distB_all } = bfs(B, n2, adj2);
        for (let i = 0; i < n2; i++) {
            maxDepth2[i] = Math.max(distA[i], distB_all[i]);
        }
    }

    // Calculate the minimum possible length of a path that crosses the new connecting edge
    let minCrossPathLength = Infinity;
    for (let i = 0; i < n1; i++) {
        for (let j = 0; j < n2; j++) {
            // A path crossing the new edge (i, j) would have length:
            // (max distance from i in tree1) + 1 (for the new edge) + (max distance from j in tree2)
            minCrossPathLength = Math.min(minCrossPathLength, maxDepth1[i] + 1 + maxDepth2[j]);
        }
    }

    // The diameter of the merged tree will be the maximum of:
    // 1. The diameter of tree1
    // 2. The diameter of tree2
    // 3. The minimum possible length of a path that crosses the new connecting edge
    return Math.max(diameter1, diameter2, minCrossPathLength);
};