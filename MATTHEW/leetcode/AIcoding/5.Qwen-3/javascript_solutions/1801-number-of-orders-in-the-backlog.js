function getNumberOfBacklogOrders(orders) {
    const buy = [];
    const sell = [];

    for (const [price, amount, orderType] of orders) {
        if (orderType === 0) {
            while (amount > 0 && sell.length > 0 && sell[0][0] <= price) {
                const [sPrice, sAmount] = sell[0];
                if (sAmount > amount) {
                    sell[0][0] = sPrice;
                    sell[0][1] -= amount;
                    amount = 0;
                } else {
                    amount -= sAmount;
                    sell.shift();
                }
            }
            if (amount > 0) {
                buy.push([price, amount]);
                buy.sort((a, b) => b[0] - a[0]);
            }
        } else {
            while (amount > 0 && buy.length > 0 && buy[0][0] >= price) {
                const [bPrice, bAmount] = buy[0];
                if (bAmount > amount) {
                    buy[0][0] = bPrice;
                    buy[0][1] -= amount;
                    amount = 0;
                } else {
                    amount -= bAmount;
                    buy.shift();
                }
            }
            if (amount > 0) {
                sell.push([price, amount]);
                sell.sort((a, b) => a[0] - b[0]);
            }
        }
    }

    let total = 0;
    for (const [_, amount] of buy) {
        total += amount;
    }
    for (const [_, amount] of sell) {
        total += amount;
    }
    return total % (10 ** 9 + 7);
}