var findCheapestPrice = function(n, flights, src, dst, k) {
    let prices = new Array(n).fill(Infinity);
    prices[src] = 0;

    for (let i = 0; i <= k; i++) {
        let tempPrices = [...prices];
        for (const [from, to, price] of flights) {
            if (prices[from] === Infinity) continue;
            if (prices[from] + price < tempPrices[to]) {
                tempPrices[to] = prices[from] + price;
            }
        }
        prices = tempPrices;
    }

    return prices[dst] === Infinity ? -1 : prices[dst];
};