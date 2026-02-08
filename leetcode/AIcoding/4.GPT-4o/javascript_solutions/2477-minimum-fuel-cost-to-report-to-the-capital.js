var minimumFuelCost = function(roads, seats) {
    const graph = new Map();
    for (const [from, to] of roads) {
        if (!graph.has(from)) graph.set(from, []);
        if (!graph.has(to)) graph.set(to, []);
        graph.get(from).push(to);
        graph.get(to).push(from);
    }

    let totalFuel = 0;

    const dfs = (node, parent) => {
        let passengers = 1;
        for (const neighbor of graph.get(node)) {
            if (neighbor !== parent) {
                passengers += dfs(neighbor, node);
            }
        }
        if (node !== 0) {
            totalFuel += Math.ceil(passengers / seats);
        }
        return passengers;
    };

    dfs(0, -1);
    return totalFuel;
};