class Solution {
    dfs(node, graph, visited, totalQuality, maxQuality, start, end) {
        if (node === end) {
            maxQuality[0] = Math.max(maxQuality[0], totalQuality);
            return;
        }
        for (const [neighbor, quality] of graph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                this.dfs(neighbor, graph, visited, totalQuality + quality, maxQuality, start, end);
                visited[neighbor] = false;
            }
        }
    }

    maximumPathQuality(edges, values, start, end) {
        const graph = Array.from({ length: values.length }, () => []);
        for (const [u, v] of edges) {
            graph[u].push([v, values[v]]);
            graph[v].push([u, values[u]]);
        }
        const visited = Array(values.length).fill(false);
        const maxQuality = [values[start]];
        visited[start] = true;
        this.dfs(start, graph, visited, values[start], maxQuality, start, end);
        return maxQuality[0];
    }
}