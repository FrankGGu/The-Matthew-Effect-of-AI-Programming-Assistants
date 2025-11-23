var longestCycle = function(edges) {
    const n = edges.length;
    const visited = new Array(n).fill(false);
    const stack = new Array(n).fill(false);
    let maxLength = -1;

    const dfs = (node, depth, nodeIndex) => {
        if (visited[node]) {
            if (stack[node]) {
                return depth - nodeIndex[node];
            }
            return -1;
        }

        visited[node] = true;
        stack[node] = true;
        nodeIndex[node] = depth;

        const result = edges[node] !== -1 ? dfs(edges[node], depth + 1, nodeIndex) : -1;

        stack[node] = false;
        return result;
    };

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const nodeIndex = new Array(n).fill(-1);
            maxLength = Math.max(maxLength, dfs(i, 0, nodeIndex));
        }
    }

    return maxLength;
};