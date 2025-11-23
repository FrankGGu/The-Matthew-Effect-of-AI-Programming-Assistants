var collectTheCoins = function(coins, edges) {
    const n = coins.length;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const leaves = [];
    for (let i = 0; i < n; i++) {
        if (graph[i].length === 1 && coins[i] === 0) {
            leaves.push(i);
        }
    }

    const removeLeaves = () => {
        for (const leaf of leaves) {
            for (const neighbor of graph[leaf]) {
                graph[neighbor] = graph[neighbor].filter(x => x !== leaf);
            }
            graph[leaf] = [];
        }
    };

    removeLeaves();

    let firstCoin = -1, lastCoin = -1;
    for (let i = 0; i < n; i++) {
        if (coins[i] === 1) {
            if (firstCoin === -1) firstCoin = i;
            lastCoin = i;
        }
    }

    if (firstCoin === -1) return 0;
    if (firstCoin === lastCoin) return 0;

    const bfs = (start) => {
        const queue = [start];
        const visited = new Set(queue);
        let depth = 0;

        while (queue.length) {
            const size = queue.length;
            for (let i = 0; i < size; i++) {
                const node = queue.shift();
                for (const neighbor of graph[node]) {
                    if (!visited.has(neighbor)) {
                        visited.add(neighbor);
                        queue.push(neighbor);
                    }
                }
            }
            depth++;
        }

        return depth - 1;
    };

    const depthFirst = bfs(firstCoin);
    const depthLast = bfs(lastCoin);

    return depthFirst + depthLast + 2;
};