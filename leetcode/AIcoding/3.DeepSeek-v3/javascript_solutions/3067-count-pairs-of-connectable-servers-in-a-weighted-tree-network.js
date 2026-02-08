var countPairsOfConnectableServers = function(edges, signalSpeed) {
    const n = edges.length + 1;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dfs = (node, parent, distance) => {
        let count = 0;
        if (distance % signalSpeed === 0) {
            count++;
        }
        for (const [neighbor, weight] of graph[node]) {
            if (neighbor !== parent) {
                count += dfs(neighbor, node, distance + weight);
            }
        }
        return count;
    };

    const res = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        const counts = [];
        for (const [neighbor, weight] of graph[i]) {
            counts.push(dfs(neighbor, i, weight));
        }
        let sum = 0;
        let total = 0;
        for (const cnt of counts) {
            total += sum * cnt;
            sum += cnt;
        }
        res[i] = total;
    }
    return res;
};