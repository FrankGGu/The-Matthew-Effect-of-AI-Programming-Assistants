function highestSales(stocks) {
    let maxSales = 0;
    let currentSales = 0;

    for (let i = 0; i < stocks.length; i++) {
        if (stocks[i] > 0) {
            currentSales += stocks[i];
            maxSales = Math.max(maxSales, currentSales);
        } else {
            currentSales = 0;
        }
    }

    return maxSales;
}