var minimumLines = function(stockPrices) {
    stockPrices.sort((a, b) => a[0] - b[0]);
    let lines = 0;

    for (let i = 1; i < stockPrices.length; i++) {
        if (i == 1 || (stockPrices[i][1] - stockPrices[i-1][1]) * (stockPrices[i-1][0] - stockPrices[i-2][0]) !== (stockPrices[i-1][1] - stockPrices[i-2][1]) * (stockPrices[i][0] - stockPrices[i-1][0])) {
            lines++;
        }
    }

    return lines;
};