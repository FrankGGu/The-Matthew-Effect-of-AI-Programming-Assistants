function magnificentSets(n, edges) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = Array(n + 1).fill(false);
    let maxGroups = 0;

    function bfs(start) {
        const queue = [start];
        visited[start] = true;
        let groupCount = 1;

        while (queue.length) {
            const current = queue.shift();
            for (const neighbor of graph[current]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.push(neighbor);
                    groupCount++;
                }
            }
        }
        return groupCount;
    }

    for (let i = 1; i <= n; i++) {
        if (!visited[i]) {
            const count = bfs(i);
            maxGroups += count - 1;
        }
    }

    return maxGroups + 1;
}