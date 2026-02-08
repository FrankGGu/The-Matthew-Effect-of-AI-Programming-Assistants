var minimumFuelCost = function(roads, seats) {
    const n = roads.length + 1;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of roads) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let fuel = 0;
    const dfs = (node, parent) => {
        let people = 1;
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                people += dfs(neighbor, node);
            }
        }
        if (node !== 0) {
            fuel += Math.ceil(people / seats);
        }
        return people;
    };

    dfs(0, -1);
    return fuel;
};