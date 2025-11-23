function minimumFuelCost(n, roads) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of roads) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let totalFuel = 0;

    function dfs(node, parent) {
        let cars = 1;
        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            const childCars = dfs(neighbor, node);
            cars += childCars;
            totalFuel += childCars;
        }
        return cars;
    }

    dfs(0, -1);
    return totalFuel;
}