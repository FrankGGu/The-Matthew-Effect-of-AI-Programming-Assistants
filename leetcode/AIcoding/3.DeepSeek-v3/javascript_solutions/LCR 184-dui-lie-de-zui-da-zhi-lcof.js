class Checkout {
    constructor() {
        this.items = [];
        this.discounts = {
            'A': { count: 3, price: 75 },
            'B': { count: 2, price: 35 }
        };
        this.prices = {
            'A': 50,
            'B': 30,
            'C': 20,
            'D': 15
        };
    }

    scan(item) {
        this.items.push(item);
    }

    total() {
        const counts = {};
        let total = 0;

        for (const item of this.items) {
            counts[item] = (counts[item] || 0) + 1;
        }

        for (const item in counts) {
            if (this.discounts[item]) {
                const discount = this.discounts[item];
                const discountCount = Math.floor(counts[item] / discount.count);
                const remainingCount = counts[item] % discount.count;
                total += discountCount * discount.price + remainingCount * this.prices[item];
            } else {
                total += counts[item] * this.prices[item];
            }
        }

        return total;
    }
}