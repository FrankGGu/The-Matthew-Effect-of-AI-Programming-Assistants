var canCompleteCircuit = function(gas, cost) {
    let totalTank = 0;
    let currentTank = 0;
    let startStation = 0;

    for (let i = 0; i < gas.length; i++) {
        totalTank += gas[i] - cost[i];
        currentTank += gas[i] - cost[i];

        if (currentTank < 0) {
            startStation = i + 1;
            currentTank = 0;
        }
    }

    return totalTank >= 0 ? startStation : -1;
};