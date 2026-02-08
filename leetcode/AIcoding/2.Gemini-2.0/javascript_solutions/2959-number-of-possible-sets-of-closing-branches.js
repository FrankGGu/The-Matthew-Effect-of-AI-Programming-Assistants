var numberOfSets = function(n, roads, cost) {
    let adj = new Array(n).fill(null).map(() => []);
    for (let [u, v, w] of roads) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    let ans = 0;
    for (let mask = 0; mask < (1 << n); mask++) {
        let totalCost = 0;
        for (let [u, v, w] of roads) {
            if ((mask & (1 << u)) && (mask & (1 << v))) {
                totalCost += w;
            }
        }

        if (totalCost <= cost) {
            ans++;
        }
    }

    return ans;
};