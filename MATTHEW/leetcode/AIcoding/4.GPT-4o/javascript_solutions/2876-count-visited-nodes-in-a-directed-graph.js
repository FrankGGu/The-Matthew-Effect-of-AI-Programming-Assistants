class Solution {
    countVisitedNodes(n, edges, start) {
        const graph = Array.from({ length: n }, () => []);
        for (const [u, v] of edges) {
            graph[u].push(v);
        }

        const visited = new Set();
        const dfs = (node) => {
            if (visited.has(node)) return;
            visited.add(node);
            for (const neighbor of graph[node]) {
                dfs(neighbor);
            }
        };

        dfs(start);
        return visited.size;
    }
}