var findMaximumElegance = function(items, k) {
    items.sort((a, b) => b[1] - a[1]);
    let seen = new Set(), totalElegance = 0, totalPrice = 0;

    for (let i = 0; i < items.length; i++) {
        if (seen.size < k) {
            seen.add(items[i][0]);
            totalPrice += items[i][1];
            totalElegance += items[i][1];
        } else {
            const minPriceItem = Math.min(...Array.from(seen).map(x => items[x][1]));
            if (items[i][1] > minPriceItem) {
                seen.delete(Array.from(seen).find(x => items[x][1] === minPriceItem));
                seen.add(items[i][0]);
                totalPrice += items[i][1] - minPriceItem;
                totalElegance += items[i][1] - minPriceItem;
            }
        }
    }

    let uniqueCount = seen.size;
    return totalElegance + uniqueCount * uniqueCount;
};