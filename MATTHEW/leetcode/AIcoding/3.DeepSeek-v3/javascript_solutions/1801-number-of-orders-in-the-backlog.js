var getNumberOfBacklogOrders = function(orders) {
    const buy = new MaxPriorityQueue({ priority: (order) => order.price });
    const sell = new MinPriorityQueue({ priority: (order) => order.price });

    for (const [price, amount, orderType] of orders) {
        if (orderType === 0) {
            while (amount > 0 && !sell.isEmpty() && sell.front().element.price <= price) {
                const sellOrder = sell.dequeue().element;
                const minAmount = Math.min(amount, sellOrder.amount);
                amount -= minAmount;
                sellOrder.amount -= minAmount;
                if (sellOrder.amount > 0) {
                    sell.enqueue(sellOrder);
                }
            }
            if (amount > 0) {
                buy.enqueue({ price, amount });
            }
        } else {
            while (amount > 0 && !buy.isEmpty() && buy.front().element.price >= price) {
                const buyOrder = buy.dequeue().element;
                const minAmount = Math.min(amount, buyOrder.amount);
                amount -= minAmount;
                buyOrder.amount -= minAmount;
                if (buyOrder.amount > 0) {
                    buy.enqueue(buyOrder);
                }
            }
            if (amount > 0) {
                sell.enqueue({ price, amount });
            }
        }
    }

    let total = 0;
    const MOD = 1e9 + 7;

    while (!buy.isEmpty()) {
        total = (total + buy.dequeue().element.amount) % MOD;
    }

    while (!sell.isEmpty()) {
        total = (total + sell.dequeue().element.amount) % MOD;
    }

    return total;
};