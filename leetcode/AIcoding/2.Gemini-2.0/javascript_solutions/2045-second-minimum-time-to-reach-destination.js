var secondMinimum = function(n, edges, time, change) {
    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = Array(n + 1).fill(null).map(() => [Infinity, Infinity]);
    dist[1][0] = 0;

    const pq = [[1, 0]];

    while (pq.length > 0) {
        pq.sort((a, b) => a[1] - b[1]);
        const [u, d] = pq.shift();

        for (const v of adj[u]) {
            if (d + 1 < dist[v][0]) {
                dist[v][1] = dist[v][0];
                dist[v][0] = d + 1;
                pq.push([v, d + 1]);
                pq.push([v, dist[v][1]]);
            } else if (d + 1 > dist[v][0] && d + 1 < dist[v][1]) {
                dist[v][1] = d + 1;
                pq.push([v, d + 1]);
            }
        }
    }

    let ans = 0;
    for (let i = 0; i < dist[n][1]; i++) {
        ans += time;
        if (ans % (2 * change) >= change) {
            ans += (2 * change - (ans % (2 * change)));
        }
    }
    return ans;
};