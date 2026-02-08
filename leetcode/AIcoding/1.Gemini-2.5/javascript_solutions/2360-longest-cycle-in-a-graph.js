var longestCycle = function(n, edges) {
    let maxCycleLength = -1;
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const pathVisited = new Array(n).fill(-1); // Stores distance from current traversal start
            let currentNode = i;
            let currentDist = 0;

            while (currentNode !== -1 && !visited[currentNode]) {
                visited[currentNode] = true;
                pathVisited[currentNode] = currentDist;

                currentNode = edges[currentNode];
                currentDist++;
            }

            if (currentNode !== -1 && pathVisited[currentNode] !== -1) {
                const cycleLength = currentDist - pathVisited[currentNode];
                maxCycleLength = Math.max(maxCycleLength, cycleLength);
            }
        }
    }

    return maxCycleLength;
};