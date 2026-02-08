var mostProfitablePath = function(edges, bob, amount) {
    const n = amount.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const bobPath = Array(n).fill(-1);
    const visited = Array(n).fill(false);

    function findBobPath(node, path) {
        visited[node] = true;
        path.push(node);

        if (node === 0) {
            path.pop();
            visited[node] = false;
            return false;
        }

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                if (findBobPath(neighbor, path)) {
                    bobPath[node] = neighbor;
                    path.pop();
                    visited[node] = false;
                    return true;
                }
            }
        }
        path.pop();
        visited[node] = false;
        return false;
    }

    findBobPath(bob, []);

    const aliceProfit = Array(n).fill(0);
    const aliceVisited = Array(n).fill(false);

    function dfs(node, depth) {
        aliceVisited[node] = true;
        let maxProfit = -Infinity;
        let profit = amount[node];

        if (bobPath[node] !== -1) {
            if (depth === 0) {
                profit = amount[node] / 2;
            } else if (depth > 0) {
                profit = 0;
            }
        }

        let isLeaf = true;
        for (const neighbor of adj[node]) {
            if (!aliceVisited[neighbor]) {
                isLeaf = false;
                maxProfit = Math.max(maxProfit, dfs(neighbor, depth + 1));
            }
        }

        if (isLeaf) {
            return profit;
        }

        return profit + maxProfit;
    }

    return dfs(0, 0);
};