var collectTheCoins = function(coins, edges) {
    const n = coins.length;
    const adj = Array.from({ length: n }, () => []);
    const degree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
        degree[u]++;
        degree[v]++;
    }

    let q = [];
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1 && coins[i] === 0) {
            q.push(i);
        }
    }

    while (q.length > 0) {
        const u = q.shift();
        for (const v of adj[u]) {
            degree[v]--;
            if (degree[v] === 1 && coins[v] === 0) {
                q.push(v);
            }
        }
    }

    q = [];
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1 && coins[i] === 1) {
            q.push(i);
        }
    }

    if (q.length <= 1) {
        return 0;
    }

    const dist = new Array(n).fill(-1);
    let start = q[0];
    q = [start];
    dist[start] = 0;
    let maxDist = 0, farthestNode = start;

    while (q.length > 0) {
        const u = q.shift();
        for (const v of adj[u]) {
            if (degree[v] > 0 && dist[v] === -1) {
                dist[v] = dist[u] + 1;
                q.push(v);
                if (dist[v] > maxDist) {
                    maxDist = dist[v];
                    farthestNode = v;
                }
            }
        }
    }

    dist.fill(-1);
    start = farthestNode;
    q = [start];
    dist[start] = 0;
    maxDist = 0;

    while (q.length > 0) {
        const u = q.shift();
        for (const v of adj[u]) {
            if (degree[v] > 0 && dist[v] === -1) {
                dist[v] = dist[u] + 1;
                q.push(v);
                if (dist[v] > maxDist) {
                    maxDist = dist[v];
                }
            }
        }
    }

    return Math.max(0, (maxDist - 1) * 2);
};