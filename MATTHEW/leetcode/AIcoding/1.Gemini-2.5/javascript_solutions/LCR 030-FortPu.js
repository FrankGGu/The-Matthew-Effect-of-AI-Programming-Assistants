var RandomizedSet = function() {
    this.list = [];
    this.map = new Map();
};

RandomizedSet.prototype.insert = function(val) {
    if (this.map.has(val)) {
        return false;
    }
    this.map.set(val, this.list.length);
    this.list.push(val);
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (!this.map.has(val)) {
        return false;
    }

    const indexToRemove = this.map.get(val);
    const lastElement = this.list[this.list.length - 1];

    // Move the last element to the place of the element to be removed
    this.list[indexToRemove] = lastElement;
    this.map.set(lastElement, indexToRemove);

    // Remove the element from the map and the last element from the list
    this.map.delete(val);
    this.list.pop();

    return true;
};

RandomizedSet.prototype.getRandom = function() {
    const randomIndex = Math.floor(Math.random() * this.list.length);
    return this.list[randomIndex];
};