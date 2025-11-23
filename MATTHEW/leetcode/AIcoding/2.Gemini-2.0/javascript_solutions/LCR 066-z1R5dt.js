var MapSum = function() {
    this.map = new Map();
};

MapSum.prototype.insert = function(key, val) {
    this.map.set(key, val);
};

MapSum.prototype.sum = function(prefix) {
    let sum = 0;
    for (let [key, val] of this.map) {
        if (key.startsWith(prefix)) {
            sum += val;
        }
    }
    return sum;
};