function secondMinimum(n, edges, time, change) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const pq = [[0, 1, 0]];
    const visited = Array.from({ length: n + 1 }, () => new Set());

    while (pq.length) {
        const [curTime, node, count] = pq.shift();

        if (node === n && count === 1) return curTime;

        if (count < 2) {
            visited[node].add(count);
            for (const neighbor of graph[node]) {
                let nextTime = curTime + time;
                if ((curTime / change) % 2 === 1) {
                    nextTime += change - (curTime % change);
                }
                if (!visited[neighbor].has(count)) {
                    pq.push([nextTime, neighbor, count + 1]);
                }
            }
        }
    }
    return -1;
}