function minCostToConnectAllPoints(points) {
    const n = points.length;
    const visited = new Array(n).fill(false);
    const minDist = new Array(n).fill(Infinity);
    minDist[0] = 0;
    let totalCost = 0;

    for (let i = 0; i < n; i++) {
        let minIndex = -1;
        let minVal = Infinity;

        for (let j = 0; j < n; j++) {
            if (!visited[j] && minDist[j] < minVal) {
                minVal = minDist[j];
                minIndex = j;
            }
        }

        if (minIndex === -1) break;

        visited[minIndex] = true;
        totalCost += minVal;

        for (let j = 0; j < n; j++) {
            if (!visited[j]) {
                const dist = Math.abs(points[minIndex][0] - points[j][0]) + Math.abs(points[minIndex][1] - points[j][1]);
                if (dist < minDist[j]) {
                    minDist[j] = dist;
                }
            }
        }
    }

    return totalCost;
}