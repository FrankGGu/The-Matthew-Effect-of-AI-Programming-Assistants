var maximumRobots = function (charges, budget) {
    let left = 0, right = 0, totalCost = 0, maxRobots = 0, n = charges.length;
    const costs = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        costs[i + 1] = costs[i] + charges[i];
    }

    while (right < n) {
        totalCost = costs[right + 1] - costs[left];
        while (totalCost > budget) {
            left++;
            totalCost = costs[right + 1] - costs[left];
        }
        maxRobots = Math.max(maxRobots, right - left + 1);
        right++;
    }

    return maxRobots;
};