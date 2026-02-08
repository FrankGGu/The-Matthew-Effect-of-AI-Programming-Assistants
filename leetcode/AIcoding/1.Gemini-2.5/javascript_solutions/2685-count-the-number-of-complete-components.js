function countCompleteComponents(n, edges) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let completeComponentsCount = 0;
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const queue = [i];
            visited[i] = true;
            const componentNodes = [];
            let sumOfDegrees = 0;

            let head = 0;
            while (head < queue.length) {
                const u = queue[head++];
                componentNodes.push(u);
                sumOfDegrees += adj[u].length;

                for (const v of adj[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        queue.push(v);
                    }
                }
            }

            const V = componentNodes.length;
            // For a complete graph with V nodes, the sum of degrees is V * (V - 1).
            // Each node is connected to every other V-1 node.
            // Sum of degrees = sum(degree(u)) for u in component = V * (V - 1).
            if (V * (V - 1) === sumOfDegrees) {
                completeComponentsCount++;
            }
        }
    }

    return completeComponentsCount;
}