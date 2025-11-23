function eventualSafeStates(graph) {
    const n = graph.length;
    const color = new Array(n).fill(0); // 0: white (unvisited), 1: gray (visiting), 2: black (visited)

    function dfs(node) {
        if (color[node] === 1) return false; // cycle detected
        if (color[node] === 2) return true; // already processed

        color[node] = 1; // mark as visiting
        for (const neighbor of graph[node]) {
            if (!dfs(neighbor)) {
                return false;
            }
        }
        color[node] = 2; // mark as visited
        return true;
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (dfs(i)) {
            result.push(i);
        }
    }
    return result;
}