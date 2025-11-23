function maximumSpending(prices, budget) {
    prices.sort((a, b) => a - b);
    let totalSpent = 0, itemsBought = 0;

    for (let price of prices) {
        if (totalSpent + price <= budget) {
            totalSpent += price;
            itemsBought++;
        } else {
            break;
        }
    }

    return totalSpent;
}