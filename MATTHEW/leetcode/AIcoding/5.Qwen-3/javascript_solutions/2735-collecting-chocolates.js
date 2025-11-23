function minCostToCollectAllChocolates(cost, positions) {
    const n = cost.length;
    const m = positions.length;
    const indexMap = new Map();

    for (let i = 0; i < m; i++) {
        indexMap.set(positions[i], i);
    }

    const sortedPositions = [...positions].sort((a, b) => a - b);

    let totalCost = 0;
    let prev = 0;

    for (let i = 0; i < m; i++) {
        const current = sortedPositions[i];
        const steps = Math.abs(current - prev);
        totalCost += steps * cost[indexMap.get(current)];
        prev = current;
    }

    return totalCost;
}