class TreeNode {
    constructor(name) {
        this.name = name;
        this.children = [];
        this.isDead = false;
    }
}

class ThroneInheritance {
    constructor(kingName) {
        this.king = new TreeNode(kingName);
        this.map = new Map();
        this.map.set(kingName, this.king);
    }

    birth(parentName, childName) {
        const parent = this.map.get(parentName);
        const child = new TreeNode(childName);
        parent.children.push(child);
        this.map.set(childName, child);
    }

    death(name) {
        const person = this.map.get(name);
        if (person) {
            person.isDead = true;
        }
    }

    getInheritanceOrder() {
        const order = [];

        const dfs = (node) => {
            if (!node.isDead) {
                order.push(node.name);
            }
            for (let child of node.children) {
                dfs(child);
            }
        };

        dfs(this.king);
        return order;
    }
}