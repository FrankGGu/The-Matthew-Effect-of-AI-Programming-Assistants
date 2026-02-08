var minOperationsMaxProfit = function(customers, boardingCost, runningCost) {
    let maxProfit = 0, maxBoarded = 0, profit = 0, totalBoarded = 0, totalRunningCost = 0;
    let maxOperations = -1, operations = 0;

    for (let i = 0; i < customers.length || totalBoarded > 0; i++) {
        if (i < customers.length) {
            totalBoarded += customers[i];
        }
        const board = Math.min(totalBoarded, 4);
        totalBoarded -= board;
        profit += board * boardingCost - runningCost;
        operations++;

        if (profit > maxProfit) {
            maxProfit = profit;
            maxOperations = operations;
            maxBoarded = board;
        }
    }

    return maxOperations;
};