var maxSpending = function(values) {
    const m = values.length;
    const n = values[0].length;
    const products = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            products.push(values[i][j]);
        }
    }

    products.sort((a, b) => a - b);

    let total = 0;
    for (let day = 1; day <= products.length; day++) {
        total += day * products[day - 1];
    }

    return total;
};