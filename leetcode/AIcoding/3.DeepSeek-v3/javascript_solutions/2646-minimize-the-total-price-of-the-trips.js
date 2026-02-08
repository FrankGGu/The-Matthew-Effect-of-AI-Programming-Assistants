var minimumTotalPrice = function(n, edges, price, trips) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const count = new Array(n).fill(0);
    for (const [start, end] of trips) {
        const parent = new Array(n).fill(-1);
        const visited = new Array(n).fill(false);
        const queue = [start];
        visited[start] = true;
        let found = false;
        while (queue.length > 0 && !found) {
            const u = queue.shift();
            for (const v of adj[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    parent[v] = u;
                    if (v === end) {
                        found = true;
                        break;
                    }
                    queue.push(v);
                }
            }
        }
        let node = end;
        while (node !== -1) {
            count[node]++;
            node = parent[node];
        }
    }

    const memo = new Map();
    function dfs(u, parent, canHalve) {
        const key = `${u},${canHalve}`;
        if (memo.has(key)) return memo.get(key);
        let res = price[u] * count[u];
        if (canHalve) {
            res = Math.min(res, Math.floor(price[u] / 2) * count[u]);
        }
        for (const v of adj[u]) {
            if (v !== parent) {
                if (canHalve) {
                    res += dfs(v, u, false);
                } else {
                    res += Math.min(dfs(v, u, true), dfs(v, u, false));
                }
            }
        }
        memo.set(key, res);
        return res;
    }

    return Math.min(dfs(0, -1, true), dfs(0, -1, false));
};