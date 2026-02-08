class Solution {
    timeToMarkAllNodes(n, edges, time) {
        const graph = Array.from({ length: n }, () => []);
        for (const [u, v] of edges) {
            graph[u].push(v);
            graph[v].push(u);
        }

        const visited = new Array(n).fill(false);
        let totalTime = 0;

        const dfs = (node) => {
            visited[node] = true;
            for (const neighbor of graph[node]) {
                if (!visited[neighbor]) {
                    totalTime += time;
                    dfs(neighbor);
                }
            }
        };

        dfs(0);
        return totalTime;
    }
}