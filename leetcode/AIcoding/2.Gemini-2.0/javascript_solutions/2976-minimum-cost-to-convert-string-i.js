var minimumCost = function(source, target, original, changed, cost) {
    const n = source.length;
    const m = original.length;
    const charCodeA = 'a'.charCodeAt(0);
    const charCodeZ = 'z'.charCodeAt(0);
    const numChars = charCodeZ - charCodeA + 1;

    const adjMatrix = Array(numChars).fill(null).map(() => Array(numChars).fill(Infinity));
    for (let i = 0; i < numChars; i++) {
        adjMatrix[i][i] = 0;
    }

    for (let i = 0; i < m; i++) {
        const from = original[i].charCodeAt(0) - charCodeA;
        const to = changed[i].charCodeAt(0) - charCodeA;
        adjMatrix[from][to] = Math.min(adjMatrix[from][to], cost[i]);
    }

    for (let k = 0; k < numChars; k++) {
        for (let i = 0; i < numChars; i++) {
            for (let j = 0; j < numChars; j++) {
                adjMatrix[i][j] = Math.min(adjMatrix[i][j], adjMatrix[i][k] + adjMatrix[k][j]);
            }
        }
    }

    let totalCost = 0;
    for (let i = 0; i < n; i++) {
        if (source[i] === target[i]) {
            continue;
        }
        const from = source[i].charCodeAt(0) - charCodeA;
        const to = target[i].charCodeAt(0) - charCodeA;
        if (adjMatrix[from][to] === Infinity) {
            return -1;
        }
        totalCost += adjMatrix[from][to];
    }

    return totalCost;
};