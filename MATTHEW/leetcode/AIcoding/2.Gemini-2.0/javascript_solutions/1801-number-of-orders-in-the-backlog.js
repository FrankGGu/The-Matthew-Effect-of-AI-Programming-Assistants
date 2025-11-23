var getNumberOfBacklogOrders = function(orders) {
    const buyOrders = [];
    const sellOrders = [];
    const MOD = 10**9 + 7;

    const insertBuyOrder = (price, amount) => {
        let i = 0;
        while (i < buyOrders.length && buyOrders[i][0] > price) {
            i++;
        }
        buyOrders.splice(i, 0, [price, amount]);
    };

    const insertSellOrder = (price, amount) => {
        let i = 0;
        while (i < sellOrders.length && sellOrders[i][0] < price) {
            i++;
        }
        sellOrders.splice(i, 0, [price, amount]);
    };

    for (const [price, amount, orderType] of orders) {
        if (orderType === 0) { // Buy order
            let remainingAmount = amount;
            while (remainingAmount > 0 && sellOrders.length > 0 && sellOrders[0][0] <= price) {
                const sellPrice = sellOrders[0][0];
                const sellAmount = sellOrders[0][1];
                if (sellAmount <= remainingAmount) {
                    remainingAmount -= sellAmount;
                    sellOrders.shift();
                } else {
                    sellOrders[0][1] -= remainingAmount;
                    remainingAmount = 0;
                }
            }
            if (remainingAmount > 0) {
                insertBuyOrder(price, remainingAmount);
            }
        } else { // Sell order
            let remainingAmount = amount;
            while (remainingAmount > 0 && buyOrders.length > 0 && buyOrders[0][0] >= price) {
                const buyPrice = buyOrders[0][0];
                const buyAmount = buyOrders[0][1];
                if (buyAmount <= remainingAmount) {
                    remainingAmount -= buyAmount;
                    buyOrders.shift();
                } else {
                    buyOrders[0][1] -= remainingAmount;
                    remainingAmount = 0;
                }
            }
            if (remainingAmount > 0) {
                insertSellOrder(price, remainingAmount);
            }
        }
    }

    let totalOrders = 0;
    for (const [price, amount] of buyOrders) {
        totalOrders = (totalOrders + amount) % MOD;
    }
    for (const [price, amount] of sellOrders) {
        totalOrders = (totalOrders + amount) % MOD;
    }

    return totalOrders;
};