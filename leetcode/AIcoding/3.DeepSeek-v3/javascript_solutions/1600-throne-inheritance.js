class ThroneInheritance {
    constructor(kingName) {
        this.king = kingName;
        this.children = {};
        this.dead = new Set();
    }

    birth(parentName, childName) {
        if (!this.children[parentName]) {
            this.children[parentName] = [];
        }
        this.children[parentName].push(childName);
    }

    death(name) {
        this.dead.add(name);
    }

    getInheritanceOrder() {
        const order = [];
        this.dfs(this.king, order);
        return order;
    }

    dfs(name, order) {
        if (!this.dead.has(name)) {
            order.push(name);
        }
        if (this.children[name]) {
            for (const child of this.children[name]) {
                this.dfs(child, order);
            }
        }
    }
}