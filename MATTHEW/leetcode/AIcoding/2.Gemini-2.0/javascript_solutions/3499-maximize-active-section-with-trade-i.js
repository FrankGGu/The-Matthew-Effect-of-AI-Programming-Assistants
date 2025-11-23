var maximizeProfit = function(inventory, orders) {
    let left = 1;
    let right = Math.max(...inventory);
    let mod = 10**9 + 7;

    while (left < right) {
        let mid = Math.floor((left + right + 1) / 2);
        let possibleOrders = 0;
        for (let item of inventory) {
            if (item > mid) {
                possibleOrders += item - mid;
            }
        }

        if (possibleOrders >= orders) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    let profit = 0;
    let remainingOrders = orders;
    for (let item of inventory) {
        if (item > left) {
            let count = item - left;
            profit = (profit + (item + left + 1) * count / 2) % mod;
            remainingOrders -= count;
        }
    }

    profit = (profit + remainingOrders * left) % mod;
    return profit;
};