var buildMatrix = function(k, rowConditions, colConditions) {
    const topologicalSort = (n, conditions) => {
        const adj = Array(n).fill(null).map(() => []);
        const indegree = Array(n).fill(0);
        for (const [u, v] of conditions) {
            adj[u - 1].push(v - 1);
            indegree[v - 1]++;
        }

        const queue = [];
        for (let i = 0; i < n; i++) {
            if (indegree[i] === 0) {
                queue.push(i);
            }
        }

        const result = [];
        while (queue.length > 0) {
            const u = queue.shift();
            result.push(u);
            for (const v of adj[u]) {
                indegree[v]--;
                if (indegree[v] === 0) {
                    queue.push(v);
                }
            }
        }

        return result.length === n ? result : [];
    };

    const rowOrder = topologicalSort(k, rowConditions);
    const colOrder = topologicalSort(k, colConditions);

    if (rowOrder.length === 0 || colOrder.length === 0) {
        return [];
    }

    const matrix = Array(k).fill(null).map(() => Array(k).fill(0));
    const colMap = {};
    for (let i = 0; i < k; i++) {
        colMap[colOrder[i]] = i;
    }

    for (let i = 0; i < k; i++) {
        matrix[i][colMap[rowOrder[i]]] = rowOrder[i] + 1;
    }

    return matrix;
};