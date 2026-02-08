function countSubtreesWithMaxDistanceBetweenCities(n, edges) {
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const result = Array(n).fill(0);

    function dfs(node, parent) {
        const count = [0, 0];
        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            const [childCount, childMax] = dfs(neighbor, node);
            count[0] += childCount;
            count[1] = Math.max(count[1], childMax);
        }
        count[0]++;
        return count;
    }

    for (let i = 0; i < n; i++) {
        const [total, max] = dfs(i, -1);
        result[max]++;
    }

    return result;
}