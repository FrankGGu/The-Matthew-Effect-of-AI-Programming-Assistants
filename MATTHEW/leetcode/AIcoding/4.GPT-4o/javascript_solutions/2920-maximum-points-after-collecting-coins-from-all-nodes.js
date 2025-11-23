var collectTheCoins = function(coins, edges) {
    const n = coins.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dfs = (node, parent) => {
        let hasCoin = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                hasCoin |= dfs(neighbor, node);
            }
        }
        return hasCoin;
    };

    const rootHasCoin = dfs(0, -1);

    if (!rootHasCoin) return 0;

    const leaves = [];

    for (let i = 0; i < n; i++) {
        if (graph[i].length === 1 && coins[i]) {
            leaves.push(i);
        }
    }

    if (leaves.length < 2) return leaves.length > 0 ? 0 : 1;

    const paths = new Set();

    const getPath = (start, end) => {
        const path = [];
        const stack = [[start, -1]];
        while (stack.length) {
            const [node, parent] = stack.pop();
            path.push(node);
            if (node === end) return path;
            for (const neighbor of graph[node]) {
                if (neighbor !== parent) {
                    stack.push([neighbor, node]);
                }
            }
        }
        return [];
    };

    for (let i = 0; i < leaves.length; i++) {
        for (let j = i + 1; j < leaves.length; j++) {
            const path = getPath(leaves[i], leaves[j]);
            for (const node of path) {
                paths.add(node);
            }
        }
    }

    return (paths.size - 1) * 2 + 1;
};