function minTotalPrice(n, roads, trips) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of roads) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const count = Array(n).fill(0);
    const visited = Array(n).fill(false);

    function dfs(node, parent) {
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                dfs(neighbor, node);
                count[node] += count[neighbor];
            }
        }
    }

    function findPath(start, end, path) {
        if (start === end) {
            return true;
        }
        visited[start] = true;
        for (const neighbor of graph[start]) {
            if (!visited[neighbor]) {
                path.push(neighbor);
                if (findPath(neighbor, end, path)) {
                    return true;
                }
                path.pop();
            }
        }
        return false;
    }

    for (const [start, end] of trips) {
        const path = [start];
        visited.fill(false);
        findPath(start, end, path);
        for (const node of path) {
            count[node]++;
        }
    }

    const res = Array(n).fill(0);
    const dp = Array(n).fill(0);

    function postDfs(node, parent) {
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                postDfs(neighbor, node);
                dp[node] += dp[neighbor];
            }
        }
        dp[node] += count[node];
    }

    postDfs(0, -1);

    return dp[0];
}