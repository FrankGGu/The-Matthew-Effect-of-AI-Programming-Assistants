function maxHappyWorkers(n, relations) {
    const graph = new Array(n).fill(0).map(() => []);
    const inDegree = new Array(n).fill(0);

    for (const [a, b] = relations[i] of relations.entries()) {
        graph[a].push(b);
        inDegree[b]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let count = 0;
    while (queue.length > 0) {
        const node = queue.shift();
        count++;
        for (const neighbor of graph[node]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return count;
}