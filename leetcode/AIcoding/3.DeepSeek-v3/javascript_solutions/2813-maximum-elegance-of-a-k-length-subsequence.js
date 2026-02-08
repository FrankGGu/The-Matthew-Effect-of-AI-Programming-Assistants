var findMaximumElegance = function(items, k) {
    items.sort((a, b) => b[0] - a[0]);
    let res = 0;
    let totalProfit = 0;
    const seenCategories = new Set();
    const duplicateProfits = [];

    for (let i = 0; i < k; i++) {
        const [profit, category] = items[i];
        totalProfit += profit;
        if (seenCategories.has(category)) {
            duplicateProfits.push(profit);
        } else {
            seenCategories.add(category);
        }
    }

    res = totalProfit + seenCategories.size * seenCategories.size;

    for (let i = k; i < items.length; i++) {
        const [profit, category] = items[i];
        if (duplicateProfits.length === 0) break;
        if (!seenCategories.has(category)) {
            const minDuplicateProfit = duplicateProfits.pop();
            totalProfit = totalProfit - minDuplicateProfit + profit;
            seenCategories.add(category);
            res = Math.max(res, totalProfit + seenCategories.size * seenCategories.size);
        }
    }

    return res;
};