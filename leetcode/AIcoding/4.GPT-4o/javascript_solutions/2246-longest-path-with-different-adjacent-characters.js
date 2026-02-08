var longestPath = function(parent, s) {
    const n = parent.length;
    const graph = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        graph[parent[i]].push(i);
    }

    let maxLength = 1;

    function dfs(node) {
        let max1 = 0, max2 = 0;
        for (const neighbor of graph[node]) {
            const length = dfs(neighbor);
            if (s[neighbor] !== s[node]) {
                if (length > max1) {
                    max2 = max1;
                    max1 = length;
                } else if (length > max2) {
                    max2 = length;
                }
            }
        }
        maxLength = Math.max(maxLength, max1 + max2 + 1);
        return max1 + 1;
    }

    dfs(0);
    return maxLength;
};