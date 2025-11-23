function largestColorValue(adj, colors) {
    const n = adj.length;
    const colorCount = Array(n).fill(0);
    const inDegree = Array(n).fill(0);
    const graph = adj.map(arr => [...arr]);

    for (let i = 0; i < n; i++) {
        for (const neighbor of graph[i]) {
            inDegree[neighbor]++;
        }
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    const maxColorCount = Array(n).fill(0).map(() => Array(26).fill(0));

    while (queue.length > 0) {
        const node = queue.shift();
        const colorIndex = colors[node];
        maxColorCount[node][colorIndex]++;

        for (const neighbor of graph[node]) {
            for (let i = 0; i < 26; i++) {
                maxColorCount[neighbor][i] = Math.max(maxColorCount[neighbor][i], maxColorCount[node][i]);
            }
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < 26; j++) {
            result = Math.max(result, maxColorCount[i][j]);
        }
    }

    return result;
}