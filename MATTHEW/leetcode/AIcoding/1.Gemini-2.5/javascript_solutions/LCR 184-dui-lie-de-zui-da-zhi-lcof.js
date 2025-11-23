class SelfCheckoutSystem {
    constructor(prices) {
        this.itemPrices = new Map();
        for (const item in prices) {
            this.itemPrices.set(item, prices[item]);
        }
        this.cart = new Map();
    }

    scan(itemName) {
        if (!this.itemPrices.has(itemName)) {
            return false;
        }
        this.cart.set(itemName, (this.cart.get(itemName) || 0) + 1);
        return true;
    }

    total() {
        let currentTotal = 0;
        for (const [itemName, count] of this.cart.entries()) {
            const price = this.itemPrices.get(itemName);
            currentTotal += price * count;
        }
        return currentTotal;
    }
}