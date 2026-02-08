var calcEquation = function(equations, values, queries) {
    const graph = {};
    for (let i = 0; i < equations.length; i++) {
        const [a, b] = equations[i];
        const value = values[i];
        if (!graph[a]) graph[a] = {};
        if (!graph[b]) graph[b] = {};
        graph[a][b] = value;
        graph[b][a] = 1 / value;
    }

    const results = [];
    for (const [start, end] of queries) {
        if (!graph[start] || !graph[end]) {
            results.push(-1.0);
            continue;
        }

        if (start === end) {
            results.push(1.0);
            continue;
        }

        const visited = new Set();
        const dfs = (node, target, currentVal) => {
            if (node === target) {
                return currentVal;
            }

            visited.add(node);
            for (const neighbor in graph[node]) {
                if (!visited.has(neighbor)) {
                    const result = dfs(neighbor, target, currentVal * graph[node][neighbor]);
                    if (result !== -1.0) {
                        return result;
                    }
                }
            }

            return -1.0;
        };

        results.push(dfs(start, end, 1.0));
    }

    return results;
};