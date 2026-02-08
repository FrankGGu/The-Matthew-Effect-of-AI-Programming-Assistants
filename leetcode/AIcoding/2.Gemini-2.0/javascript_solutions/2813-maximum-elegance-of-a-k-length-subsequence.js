var findMaximumElegance = function(items, k) {
    items.sort((a, b) => b[0] - a[0]);
    let sum = 0;
    let uniqueCategories = new Set();
    let extraProfits = [];

    for (let i = 0; i < k; i++) {
        sum += items[i][0];
        if (!uniqueCategories.has(items[i][1])) {
            uniqueCategories.add(items[i][1]);
        } else {
            extraProfits.push(items[i][0]);
        }
    }

    let maxElegance = sum + uniqueCategories.size * uniqueCategories.size;

    for (let i = k; i < items.length; i++) {
        if (!uniqueCategories.has(items[i][1])) {
            if (extraProfits.length > 0) {
                let minProfit = extraProfits.shift();
                sum -= minProfit;
                sum += items[i][0];
                uniqueCategories.add(items[i][1]);
                maxElegance = Math.max(maxElegance, sum + uniqueCategories.size * uniqueCategories.size);
            }
        }
    }

    return maxElegance;
};