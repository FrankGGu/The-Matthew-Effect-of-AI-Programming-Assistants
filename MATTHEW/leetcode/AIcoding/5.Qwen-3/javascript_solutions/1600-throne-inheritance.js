var ThroneInheritance = function(kingName) {
    this.king = kingName;
    this.family = {};
};

ThroneInheritance.prototype.birth = function(parentName, childName) {
    if (!this.family[parentName]) {
        this.family[parentName] = [];
    }
    this.family[parentName].push(childName);
};

ThroneInheritance.prototype.death = function(name) {
    if (this.family[name]) {
        delete this.family[name];
    }
};

ThroneInheritance.prototype.getInheritanceOrder = function() {
    const order = [];
    const dfs = (name) => {
        order.push(name);
        if (this.family[name]) {
            for (const child of this.family[name]) {
                dfs(child);
            }
        }
    };
    dfs(this.king);
    return order;
};