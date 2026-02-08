class InventorySystem {
    constructor() {
        this.inventory = new Map();
    }

    add(name, quantity) {
        if (this.inventory.has(name)) {
            this.inventory.set(name, this.inventory.get(name) + quantity);
        } else {
            this.inventory.set(name, quantity);
        }
    }

    remove(name, quantity) {
        if (this.inventory.has(name)) {
            const currentQuantity = this.inventory.get(name);
            if (currentQuantity > quantity) {
                this.inventory.set(name, currentQuantity - quantity);
            } else {
                this.inventory.delete(name);
            }
        }
    }

    get(name) {
        return this.inventory.get(name) || 0;
    }
}