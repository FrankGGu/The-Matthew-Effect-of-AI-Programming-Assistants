function maxItems(prices, k) {
    prices.sort((a, b) => a - b);
    let count = 0;
    let total = 0;

    for (let price of prices) {
        if (total + price <= k) {
            total += price;
            count++;
        } else {
            break;
        }
    }

    return count;
}