var findMinimumTime = function(time, start, target) {
    const n = time.length;
    const adj = Array(n).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                adj[i].push({ to: j, cost: time[i][j] });
            }
        }
    }

    const dist = Array(n).fill(Infinity);
    dist[start] = 0;
    const visited = Array(n).fill(false);

    for (let count = 0; count < n - 1; count++) {
        let u = -1;
        for (let v = 0; v < n; v++) {
            if (!visited[v] && (u === -1 || dist[v] < dist[u])) {
                u = v;
            }
        }

        if (dist[u] === Infinity) break;

        visited[u] = true;

        for (const neighbor of adj[u]) {
            const v = neighbor.to;
            const cost = neighbor.cost;
            if (dist[u] + cost < dist[v]) {
                dist[v] = dist[u] + cost;
            }
        }
    }

    return dist[target];
};