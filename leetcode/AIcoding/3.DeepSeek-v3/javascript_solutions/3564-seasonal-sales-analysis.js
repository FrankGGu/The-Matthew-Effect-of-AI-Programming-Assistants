var maxSeasonalSales = function(sales) {
    let max = -Infinity;
    for (let i = 0; i < sales.length; i++) {
        if (sales[i] > max) {
            max = sales[i];
        }
    }
    return max;
};

var minSeasonalSales = function(sales) {
    let min = Infinity;
    for (let i = 0; i < sales.length; i++) {
        if (sales[i] < min) {
            min = sales[i];
        }
    }
    return min;
};

var averageSeasonalSales = function(sales) {
    let sum = 0;
    for (let i = 0; i < sales.length; i++) {
        sum += sales[i];
    }
    return sum / sales.length;
};

var seasonalSalesTrend = function(sales) {
    let trend = [];
    for (let i = 1; i < sales.length; i++) {
        trend.push(sales[i] - sales[i - 1]);
    }
    return trend;
};