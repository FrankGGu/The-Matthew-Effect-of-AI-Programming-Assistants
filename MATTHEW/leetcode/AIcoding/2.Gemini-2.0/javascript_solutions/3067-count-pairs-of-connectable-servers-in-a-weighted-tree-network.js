var countPairs = function(n, edges, signalSpeed) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const ans = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let counts = [];
        for (const [neighbor, weight] of adj[i]) {
            let count = 0;
            let visited = new Set([i]);

            const dfs = (node, totalWeight) => {
                visited.add(node);
                if (totalWeight % signalSpeed === 0 && node !== i) {
                    count++;
                }

                for (const [nextNeighbor, nextWeight] of adj[node]) {
                    if (!visited.has(nextNeighbor)) {
                        dfs(nextNeighbor, totalWeight + nextWeight);
                    }
                }
            }

            dfs(neighbor, weight);
            counts.push(count);
        }

        for (let j = 0; j < counts.length; j++) {
            for (let k = j + 1; k < counts.length; k++) {
                ans[i] += counts[j] * counts[k];
            }
        }
    }

    return ans;
};