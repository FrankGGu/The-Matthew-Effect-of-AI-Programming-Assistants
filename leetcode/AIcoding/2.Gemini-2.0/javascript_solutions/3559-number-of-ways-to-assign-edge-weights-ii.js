var countPaths = function(n, edges) {
    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dist = Array(n + 1).fill(Infinity);
    const ways = Array(n + 1).fill(0);
    dist[1] = 0;
    ways[1] = 1;

    const pq = [[0, 1]];

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [d, u] = pq.shift();

        if (d > dist[u]) continue;

        for (const [v, w] of adj[u]) {
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                ways[v] = ways[u];
                pq.push([dist[v], v]);
            } else if (dist[v] === dist[u] + w) {
                ways[v] = (ways[v] + ways[u]) % (10**9 + 7);
            }
        }
    }

    const totalPaths = ways[n];
    const ans = Array(edges.length).fill(0);

    for (let i = 0; i < edges.length; i++) {
        const [u, v, w] = edges[i];
        const distU = Array(n + 1).fill(Infinity);
        const waysU = Array(n + 1).fill(0);
        distU[u] = 0;
        waysU[u] = 1;

        const pqU = [[0, u]];

        while (pqU.length > 0) {
            pqU.sort((a, b) => a[0] - b[0]);
            const [d, cur] = pqU.shift();

            if (d > distU[cur]) continue;

            for (const [neighbor, weight] of adj[cur]) {
                if (distU[neighbor] > distU[cur] + weight) {
                    distU[neighbor] = distU[cur] + weight;
                    waysU[neighbor] = waysU[cur];
                    pqU.push([distU[neighbor], neighbor]);
                } else if (distU[neighbor] === distU[cur] + weight) {
                    waysU[neighbor] = (waysU[neighbor] + waysU[cur]) % (10**9 + 7);
                }
            }
        }

        const distV = Array(n + 1).fill(Infinity);
        const waysV = Array(n + 1).fill(0);
        distV[v] = 0;
        waysV[v] = 1;

        const pqV = [[0, v]];

        while (pqV.length > 0) {
            pqV.sort((a, b) => a[0] - b[0]);
            const [d, cur] = pqV.shift();

            if (d > distV[cur]) continue;

            for (const [neighbor, weight] of adj[cur]) {
                if (distV[neighbor] > distV[cur] + weight) {
                    distV[neighbor] = distV[cur] + weight;
                    waysV[neighbor] = waysV[cur];
                    pqV.push([distV[neighbor], neighbor]);
                } else if (distV[neighbor] === distV[cur] + weight) {
                    waysV[neighbor] = (waysV[neighbor] + waysV[cur]) % (10**9 + 7);
                }
            }
        }

        let count = 0;
        if(distU[n] === Infinity || distV[n] === Infinity) {
            count = 0;
        }
        else if (distU[n] < distV[n]) {
           if (distU[n] === dist[u] + dist[n] - dist[v]) {
                count = (waysU[n]) % (10**9 + 7);
           }
        }
        else {
             if (distV[n] === dist[v] + dist[n] - dist[u]) {
                count = (waysV[n]) % (10**9 + 7);
           }
        }

        if (dist[u] + w + dist[n] - dist[v] === dist[n]) {
             count = (count + ways[u] * waysV[n]) % (10**9 + 7);
        }

        if (dist[v] + w + dist[n] - dist[u] === dist[n]) {
             count = (count + ways[v] * waysU[n]) % (10**9 + 7);
        }

        if (dist[u] + w + dist[v] + dist[n] - dist[u] - w === dist[n]) {
             count = (count + ways[u] * ways[v]) % (10**9 + 7);
        }
        ans[i] = (totalPaths - count + (10**9 + 7)) % (10**9 + 7);
    }

    return ans;
};