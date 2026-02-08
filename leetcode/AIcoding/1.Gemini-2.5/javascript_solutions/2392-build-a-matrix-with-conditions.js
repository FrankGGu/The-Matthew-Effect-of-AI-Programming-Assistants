var buildMatrix = function(k, rowConditions, colConditions) {
    const topoSort = (numNodes, conditions) => {
        const inDegree = new Array(numNodes + 1).fill(0);
        const adj = new Array(numNodes + 1).fill(0).map(() => []);

        for (const [u, v] of conditions) {
            adj[u].push(v);
            inDegree[v]++;
        }

        const queue = [];
        for (let i = 1; i <= numNodes; i++) {
            if (inDegree[i] === 0) {
                queue.push(i);
            }
        }

        const result = [];
        while (queue.length > 0) {
            const u = queue.shift();
            result.push(u);

            for (const v of adj[u]) {
                inDegree[v]--;
                if (inDegree[v] === 0) {
                    queue.push(v);
                }
            }
        }

        if (result.length === numNodes) {
            return result;
        } else {
            return [];
        }
    };

    const rowOrder = topoSort(k, rowConditions);
    if (rowOrder.length === 0) {
        return [];
    }

    const colOrder = topoSort(k, colConditions);
    if (colOrder.length === 0) {
        return [];
    }

    const rowPos = new Array(k + 1);
    const colPos = new Array(k + 1);

    for (let i = 0; i < k; i++) {
        rowPos[rowOrder[i]] = i;
        colPos[colOrder[i]] = i;
    }

    const matrix = new Array(k).fill(0).map(() => new Array(k).fill(0));

    for (let num = 1; num <= k; num++) {
        const r = rowPos[num];
        const c = colPos[num];
        matrix[r][c] = num;
    }

    return matrix;
};