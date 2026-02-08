var countSubgraphsForEachDiameter = function(n, edges) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = Array(n).fill(0).map(() => Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
        const q = [[i, 0]];
        const visited = new Set([i]);
        let head = 0;
        while(head < q.length){
            const [u, d] = q[head++];
            dist[i][u] = d;

            for(const v of adj[u]){
                if(!visited.has(v)){
                    visited.add(v);
                    q.push([v, d + 1]);
                }
            }
        }
    }

    const ans = Array(n - 1).fill(0);

    for (let mask = 1; mask < (1 << n); mask++) {
        const nodesInSubset = [];
        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                nodesInSubset.push(i);
            }
        }

        const numNodes = nodesInSubset.length;
        if (numNodes <= 1) {
            continue;
        }

        let visitedCount = 0;
        let edgeCount = 0;
        const q = [nodesInSubset[0]];
        const visited = new Set([nodesInSubset[0]]);
        let head = 0;

        while (head < q.length) {
            const u = q[head++];
            visitedCount++;

            for (const v of adj[u]) {
                if ((mask >> v) & 1) {
                    edgeCount++;
                    if (!visited.has(v)) {
                        visited.add(v);
                        q.push(v);
                    }
                }
            }
        }

        if (visitedCount !== numNodes || (edgeCount / 2) !== (numNodes - 1)) {
            continue;
        }

        let maxD = 0;
        for (let i = 0; i < numNodes; i++) {
            for (let j = i + 1; j < numNodes; j++) {
                const u = nodesInSubset[i];
                const v = nodesInSubset[j];
                maxD = Math.max(maxD, dist[u][v]);
            }
        }

        if (maxD > 0) {
            ans[maxD - 1]++;
        }
    }

    return ans;
};