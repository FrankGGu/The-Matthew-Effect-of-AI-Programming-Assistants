var RandomizedCollection = function() {
    this.list = [];
    this.map = new Map(); // val -> Set of indices
};

RandomizedCollection.prototype.insert = function(val) {
    const isPresent = this.map.has(val);

    if (!isPresent) {
        this.map.set(val, new Set());
    }

    this.map.get(val).add(this.list.length);
    this.list.push(val);

    return !isPresent;
};

RandomizedCollection.prototype.remove = function(val) {
    if (!this.map.has(val) || this.map.get(val).size === 0) {
        return false;
    }

    const idxToRemove = this.map.get(val).values().next().value;

    this.map.get(val).delete(idxToRemove);

    const lastVal = this.list[this.list.length - 1];
    const lastIdx = this.list.length - 1;

    if (idxToRemove !== lastIdx) {
        this.list[idxToRemove] = lastVal;

        this.map.get(lastVal).delete(lastIdx);
        this.map.get(lastVal).add(idxToRemove);
    }

    this.list.pop();

    if (this.map.get(val).size === 0) {
        this.map.delete(val);
    }

    return true;
};

RandomizedCollection.prototype.getRandom = function() {
    const randomIndex = Math.floor(Math.random() * this.list.length);
    return this.list[randomIndex];
};