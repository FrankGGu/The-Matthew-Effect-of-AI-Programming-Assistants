var mostProfitablePath = function(edges, bob, amount) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const n = edges.length + 1;
    const visited = new Array(n).fill(false);
    const bobPath = new Array(n).fill(-1);

    const dfsBob = (node, parent) => {
        if (node === 0) return 0;
        const amountAtNode = Math.floor(amount[node] / 2);
        const nextNode = graph.get(node).find(v => v !== parent);
        bobPath[node] = nextNode === undefined ? 0 : dfsBob(nextNode, node) + 1;
        return bobPath[node];
    };

    dfsBob(bob, -1);

    const dfsProfit = (node, parent, currentProfit) => {
        visited[node] = true;
        let maxProfit = currentProfit;
        for (const neighbor of graph.get(node)) {
            if (neighbor === parent) continue;
            const profitAtNeighbor = currentProfit + (amount[neighbor] - (bobPath[neighbor] === bob ? amount[neighbor] / 2 : 0));
            maxProfit = Math.max(maxProfit, dfsProfit(neighbor, node, profitAtNeighbor));
        }
        return maxProfit;
    };

    return dfsProfit(0, -1, amount[0]);
};