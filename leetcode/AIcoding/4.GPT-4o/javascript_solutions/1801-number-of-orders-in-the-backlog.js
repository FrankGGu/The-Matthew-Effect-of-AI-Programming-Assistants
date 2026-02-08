class Order {
    constructor(orderId, price, amount) {
        this.orderId = orderId;
        this.price = price;
        this.amount = amount;
    }
}

var getNumberOfBacklogOrders = function(orders) {
    const buyOrders = [];
    const sellOrders = [];
    let mod = 1e9 + 7;

    for (let order of orders) {
        let [orderType, price, amount] = order;
        if (orderType === 0) {
            while (amount > 0 && sellOrders.length > 0 && sellOrders[0][0] <= price) {
                if (amount >= sellOrders[0][1]) {
                    amount -= sellOrders[0][1];
                    sellOrders.shift();
                } else {
                    sellOrders[0][1] -= amount;
                    amount = 0;
                }
            }
            if (amount > 0) buyOrders.push([price, amount]);
        } else {
            while (amount > 0 && buyOrders.length > 0 && buyOrders[buyOrders.length - 1][0] >= price) {
                if (amount >= buyOrders[buyOrders.length - 1][1]) {
                    amount -= buyOrders[buyOrders.length - 1][1];
                    buyOrders.pop();
                } else {
                    buyOrders[buyOrders.length - 1][1] -= amount;
                    amount = 0;
                }
            }
            if (amount > 0) sellOrders.push([price, amount]);
        }
    }

    let totalBacklog = 0;
    for (let [_, amount] of buyOrders) {
        totalBacklog = (totalBacklog + amount) % mod;
    }
    for (let [_, amount] of sellOrders) {
        totalBacklog = (totalBacklog + amount) % mod;
    }

    return totalBacklog;
};