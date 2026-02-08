var ThroneInheritance = function(kingName) {
    this.king = kingName;
    this.graph = new Map();
    this.dead = new Set();
};

ThroneInheritance.prototype.birth = function(parentName, childName) {
    if (!this.graph.has(parentName)) {
        this.graph.set(parentName, []);
    }
    this.graph.get(parentName).push(childName);
};

ThroneInheritance.prototype.death = function(name) {
    this.dead.add(name);
};

ThroneInheritance.prototype.getInheritanceOrder = function() {
    const order = [];
    const dfs = (name) => {
        if (!this.dead.has(name)) {
            order.push(name);
        }
        if (this.graph.has(name)) {
            for (const child of this.graph.get(name)) {
                dfs(child);
            }
        }
    };
    dfs(this.king);
    return order;
};