var canCompleteCircuit = function(gas, cost) {
    const n = gas.length;
    let totalGas = 0, totalCost = 0, currentGas = 0, startIndex = 0;

    for (let i = 0; i < n; i++) {
        totalGas += gas[i];
        totalCost += cost[i];
        currentGas += gas[i] - cost[i];
        if (currentGas < 0) {
            startIndex = i + 1;
            currentGas = 0;
        }
    }

    return totalGas >= totalCost ? startIndex : -1;
};