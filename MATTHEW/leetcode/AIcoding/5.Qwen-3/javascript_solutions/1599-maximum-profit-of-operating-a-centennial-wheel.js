function maxProfitOperations(customers, boardingCost, workingCost) {
    let n = customers.length;
    let totalCustomers = 0;
    let maxProfit = 0;
    let maxTurns = 0;
    let currentTurn = 0;
    let i = 0;

    while (i < n || totalCustomers > 0) {
        if (i < n) {
            totalCustomers += customers[i];
            i++;
        }

        let boarded = Math.min(totalCustomers, 100);
        totalCustomers -= boarded;

        let profit = boarded * boardingCost - workingCost;
        currentTurn++;

        if (profit > maxProfit) {
            maxProfit = profit;
            maxTurns = currentTurn;
        }
    }

    return maxTurns;
}