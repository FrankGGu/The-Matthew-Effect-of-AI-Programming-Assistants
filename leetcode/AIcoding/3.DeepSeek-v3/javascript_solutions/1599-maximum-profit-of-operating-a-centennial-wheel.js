var minOperationsMaxProfit = function(customers, boardingCost, runningCost) {
    let maxProfit = 0;
    let maxProfitRotations = -1;
    let currentProfit = 0;
    let waiting = 0;
    let rotations = 0;

    for (let i = 0; i < customers.length || waiting > 0; i++) {
        if (i < customers.length) {
            waiting += customers[i];
        }
        let boarding = Math.min(4, waiting);
        waiting -= boarding;
        currentProfit += boarding * boardingCost - runningCost;
        rotations++;

        if (currentProfit > maxProfit) {
            maxProfit = currentProfit;
            maxProfitRotations = rotations;
        }
    }

    return maxProfit > 0 ? maxProfitRotations : -1;
};