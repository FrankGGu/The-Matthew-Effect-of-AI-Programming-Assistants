var magnificentSets = function(n, edges) {
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = new Array(n + 1).fill(-1);
    let res = 0;

    for (let i = 1; i <= n; i++) {
        if (visited[i] !== -1) continue;
        const queue = [i];
        visited[i] = 0;
        const nodes = [];
        let isBipartite = true;

        while (queue.length > 0) {
            const u = queue.shift();
            nodes.push(u);
            for (const v of adj[u]) {
                if (visited[v] === -1) {
                    visited[v] = visited[u] ^ 1;
                    queue.push(v);
                } else if (visited[v] === visited[u]) {
                    isBipartite = false;
                }
            }
        }

        if (!isBipartite) return -1;

        let maxGroups = 0;
        for (const start of nodes) {
            const dist = new Array(n + 1).fill(-1);
            const q = [start];
            dist[start] = 1;
            let currentMax = 1;
            while (q.length > 0) {
                const u = q.shift();
                for (const v of adj[u]) {
                    if (dist[v] === -1) {
                        dist[v] = dist[u] + 1;
                        currentMax = Math.max(currentMax, dist[v]);
                        q.push(v);
                    }
                }
            }
            maxGroups = Math.max(maxGroups, currentMax);
        }
        res += maxGroups;
    }

    return res;
};