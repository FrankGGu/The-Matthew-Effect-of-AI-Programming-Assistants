var maximumPoints = function(edges, coins, k) {
    const n = coins.length;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const memo = new Map();

    function dfs(node, parent, operations) {
        if (operations >= 14) return 0;
        const key = `${node},${operations}`;
        if (memo.has(key)) return memo.get(key);

        let option1 = (coins[node] >> operations) - k;
        let option2 = coins[node] >> (operations + 1);

        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                option1 += dfs(neighbor, node, operations);
                option2 += dfs(neighbor, node, operations + 1);
            }
        }

        const res = Math.max(option1, option2);
        memo.set(key, res);
        return res;
    }

    return dfs(0, -1, 0);
};