var buildMatrix = function(k, rowConditions, colConditions) {
    function topologicalSort(conditions) {
        const graph = Array.from({ length: k + 1 }, () => []);
        const inDegree = new Array(k + 1).fill(0);
        for (const [u, v] of conditions) {
            graph[u].push(v);
            inDegree[v]++;
        }
        const queue = [];
        for (let i = 1; i <= k; i++) {
            if (inDegree[i] === 0) {
                queue.push(i);
            }
        }
        const order = [];
        while (queue.length) {
            const u = queue.shift();
            order.push(u);
            for (const v of graph[u]) {
                inDegree[v]--;
                if (inDegree[v] === 0) {
                    queue.push(v);
                }
            }
        }
        return order.length === k ? order : null;
    }

    const rowOrder = topologicalSort(rowConditions);
    const colOrder = topologicalSort(colConditions);
    if (!rowOrder || !colOrder) return [];

    const rowPos = new Array(k + 1).fill(0);
    const colPos = new Array(k + 1).fill(0);
    for (let i = 0; i < k; i++) {
        rowPos[rowOrder[i]] = i;
        colPos[colOrder[i]] = i;
    }

    const matrix = Array.from({ length: k }, () => new Array(k).fill(0));
    for (let num = 1; num <= k; num++) {
        matrix[rowPos[num]][colPos[num]] = num;
    }
    return matrix;
};