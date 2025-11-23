var collectCoins = function(coins, edges) {
    const n = coins.length;
    const adj = Array(n).fill(null).map(() => []);
    const degree = Array(n).fill(0);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
        degree[u]++;
        degree[v]++;
    }

    let remaining = n;
    const q = [];
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1 && coins[i] === 0) {
            q.push(i);
        }
    }

    while (q.length > 0) {
        const u = q.shift();
        remaining--;
        degree[u] = 0;
        for (const v of adj[u]) {
            degree[v]--;
            if (degree[v] === 1 && coins[v] === 0) {
                q.push(v);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (degree[i] === 1) {
            q.push(i);
        }
    }

    for (let i = 0; i < 2; i++) {
        const sz = q.length;
        for (let j = 0; j < sz; j++) {
            const u = q.shift();
            remaining--;
            degree[u] = 0;
            for (const v of adj[u]) {
                degree[v]--;
            }
        }
        for (let k = 0; k < n; k++) {
            if (degree[k] > 0 && degree[k] <= 1) {
                q.push(k);
            }
        }
    }

    let ans = 0;
    for(const [u, v] of edges) {
        if(degree[u] > 0 && degree[v] > 0) {
            ans++;
        }
    }

    return ans;
};