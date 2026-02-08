var minOperationsMaxProfit = function(customers, boardingCost, runningCost) {
    let profit = 0;
    let maxProfit = -1;
    let wait = 0;
    let rotations = 0;
    let i = 0;

    while (i < customers.length || wait > 0) {
        let board = Math.min(4, wait + (i < customers.length ? customers[i] : 0));
        wait = Math.max(0, wait + (i < customers.length ? customers[i] : 0) - 4);
        profit += board * boardingCost - runningCost;
        rotations++;

        if (profit > maxProfit) {
            maxProfit = profit;
            ans = rotations;
        }

        if (i < customers.length) {
            i++;
        }
    }

    return maxProfit > 0 ? ans : -1;
};