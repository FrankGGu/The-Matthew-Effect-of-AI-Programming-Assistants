var frogPosition = function(n, edges, t, target) {
    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = Array(n + 1).fill(false);
    visited[1] = true;

    let queue = [[1, 0, 1.0]]; 

    while (queue.length > 0) {
        const [node, time, prob] = queue.shift();

        if (time > t) {
            continue;
        }

        if (node === target) {
            if (time === t || adj[node].filter(neighbor => !visited[neighbor]).length === 0) {
                return prob;
            } else {
                return 0.0;
            }
        }

        let nextNodes = adj[node].filter(neighbor => !visited[neighbor]);
        let nextNodesCount = nextNodes.length;
        let nextProb = prob / nextNodesCount;

        for (const nextNode of nextNodes) {
            visited[nextNode] = true;
            queue.push([nextNode, time + 1, nextProb]);
        }
    }

    return 0.0;
};