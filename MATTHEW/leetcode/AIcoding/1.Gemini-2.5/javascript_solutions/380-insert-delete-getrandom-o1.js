var RandomizedSet = function() {
    this.list = [];
    this.map = new Map();
};

RandomizedSet.prototype.insert = function(val) {
    if (this.map.has(val)) {
        return false;
    }
    this.list.push(val);
    this.map.set(val, this.list.length - 1);
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (!this.map.has(val)) {
        return false;
    }

    const indexToRemove = this.map.get(val);
    const lastElement = this.list[this.list.length - 1];

    // If the element to remove is not the last element,
    // swap it with the last element
    if (indexToRemove !== this.list.length - 1) {
        this.list[indexToRemove] = lastElement;
        this.map.set(lastElement, indexToRemove);
    }

    // Remove the element from the map and pop from the list
    this.map.delete(val);
    this.list.pop();

    return true;
};

RandomizedSet.prototype.getRandom = function() {
    const randomIndex = Math.floor(Math.random() * this.list.length);
    return this.list[randomIndex];
};