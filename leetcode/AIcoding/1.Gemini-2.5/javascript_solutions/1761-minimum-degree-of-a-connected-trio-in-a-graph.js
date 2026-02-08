var minTrioDegree = function(n, edges) {
    const adjMatrix = Array(n).fill(0).map(() => Array(n).fill(false));
    const degree = Array(n).fill(0);

    for (const [u, v] of edges) {
        // Adjust to 0-indexed
        const u0 = u - 1;
        const v0 = v - 1;

        adjMatrix[u0][v0] = true;
        adjMatrix[v0][u0] = true;
        degree[u0]++;
        degree[v0]++;
    }

    let minTrioDegreeSum = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            // If i and j are not connected, they cannot form a trio
            if (!adjMatrix[i][j]) {
                continue;
            }
            for (let k = j + 1; k < n; k++) {
                // If i, j, and k form a connected trio
                if (adjMatrix[i][k] && adjMatrix[j][k]) {
                    const currentTrioDegree = degree[i] + degree[j] + degree[k] - 6;
                    minTrioDegreeSum = Math.min(minTrioDegreeSum, currentTrioDegree);
                }
            }
        }
    }

    return minTrioDegreeSum === Infinity ? -1 : minTrioDegreeSum;
};