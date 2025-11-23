var ThroneInheritance = function(kingName) {
    this.kingName = kingName;
    this.childrenMap = new Map();
    this.deadSet = new Set();

    this.childrenMap.set(kingName, []);
};

ThroneInheritance.prototype.birth = function(parentName, childName) {
    this.childrenMap.get(parentName).push(childName);
    this.childrenMap.set(childName, []);
};

ThroneInheritance.prototype.death = function(name) {
    this.deadSet.add(name);
};

ThroneInheritance.prototype.getInheritanceOrder = function() {
    const order = [];
    const self = this;

    function dfs(currentPerson) {
        if (!self.deadSet.has(currentPerson)) {
            order.push(currentPerson);
        }

        const children = self.childrenMap.get(currentPerson);
        if (children) {
            for (const child of children) {
                dfs(child);
            }
        }
    }

    dfs(this.kingName);

    return order;
};