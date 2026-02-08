var minimumFuelCost = function(roads, seats) {
    const graph = new Array(roads.length + 1).fill(0).map(() => []);
    for (const [a, b] of roads) {
        graph[a].push(b);
        graph[b].push(a);
    }
    let fuel = 0;

    const dfs = (node, parent) => {
        let people = 1;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                const p = dfs(neighbor, node);
                people += p;
                fuel += Math.ceil(p / seats);
            }
        }
        return people;
    };

    dfs(0, -1);
    return fuel;
};