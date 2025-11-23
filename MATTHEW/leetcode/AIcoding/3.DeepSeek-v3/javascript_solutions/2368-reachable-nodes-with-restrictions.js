var reachableNodes = function(n, edges, restricted) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const restrictedSet = new Set(restricted);
    const visited = new Set();
    const queue = [0];
    visited.add(0);
    let count = 0;

    while (queue.length > 0) {
        const node = queue.shift();
        count++;

        for (const neighbor of graph[node]) {
            if (!visited.has(neighbor) && !restrictedSet.has(neighbor)) {
                visited.add(neighbor);
                queue.push(neighbor);
            }
        }
    }

    return count;
};