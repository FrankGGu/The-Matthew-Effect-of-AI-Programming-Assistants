var minimumFuelCost = function(roads, seats) {
    const n = roads.length + 1;
    const adj = new Array(n).fill(0).map(() => []);

    for (const [u, v] of roads) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let totalFuelCost = 0;

    // dfs returns the number of people in the subtree rooted at 'node'
    const dfs = (node, parent) => {
        let peopleCount = 1; // 1 for the person at the current node

        for (const neighbor of adj[node]) {
            if (neighbor === parent) {
                continue;
            }
            const peopleFromChildSubtree = dfs(neighbor, node);
            peopleCount += peopleFromChildSubtree;

            // Calculate cars needed to transport peopleFromChildSubtree from 'neighbor' to 'node'.
            // Each car travels 1 unit distance.
            // This cost is added to the total fuel cost.
            totalFuelCost += Math.ceil(peopleFromChildSubtree / seats);
        }
        return peopleCount;
    };

    // Start DFS from the capital (city 0).
    // The parent of the capital is set to -1 (or any value not in [0, n-1])
    // as it has no parent in the context of moving towards the capital.
    dfs(0, -1);

    return totalFuelCost;
};