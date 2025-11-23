var maxProfit = function(customers, boardingCost, runningCost) {
    let totalCustomersWaiting = 0;
    let currentProfit = 0;
    let maxProfit = 0; 
    let maxRotations = -1; 
    let rotations = 0;

    for (let i = 0; i < customers.length; i++) {
        totalCustomersWaiting += customers[i];

        rotations++;
        let boardedCustomers = Math.min(totalCustomersWaiting, 4);
        totalCustomersWaiting -= boardedCustomers;

        currentProfit += (boardedCustomers * boardingCost) - runningCost;

        if (currentProfit > maxProfit) {
            maxProfit = currentProfit;
            maxRotations = rotations;
        }
    }

    while (totalCustomersWaiting > 0) {
        rotations++;
        let boardedCustomers = Math.min(totalCustomersWaiting, 4);
        totalCustomersWaiting -= boardedCustomers;

        currentProfit += (boardedCustomers * boardingCost) - runningCost;

        if (currentProfit > maxProfit) {
            maxProfit = currentProfit;
            maxRotations = rotations;
        }
    }

    if (maxProfit <= 0) {
        return -1;
    } else {
        return maxRotations;
    }
};