var countSubgraphsForEachDiameter = function(n, edges) {
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const res = new Array(n - 1).fill(0);

    for (let mask = 1; mask < (1 << n); mask++) {
        const nodes = [];
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                nodes.push(i + 1);
            }
        }

        if (nodes.length <= 1) continue;

        let edgeCount = 0;
        for (const u of nodes) {
            for (const v of adj[u]) {
                if (nodes.includes(v)) {
                    edgeCount++;
                }
            }
        }
        edgeCount /= 2;

        if (edgeCount !== nodes.length - 1) continue;

        let maxDist = 0;
        for (const start of nodes) {
            const dist = {};
            const queue = [start];
            dist[start] = 0;
            let maxDistCurrent = 0;

            while (queue.length) {
                const u = queue.shift();
                for (const v of adj[u]) {
                    if (nodes.includes(v) && dist[v] === undefined) {
                        dist[v] = dist[u] + 1;
                        maxDistCurrent = Math.max(maxDistCurrent, dist[v]);
                        queue.push(v);
                    }
                }
            }
            maxDist = Math.max(maxDist, maxDistCurrent);
        }

        if (maxDist > 0) {
            res[maxDist - 1]++;
        }
    }

    return res;
};