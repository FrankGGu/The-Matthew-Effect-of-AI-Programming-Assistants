var MapSum = function() {
    this.map = {};
    this.prefixMap = {};
};

MapSum.prototype.insert = function(key, val) {
    const delta = val - (this.map[key] || 0);
    this.map[key] = val;
    for (let i = 1; i <= key.length; i++) {
        const prefix = key.substring(0, i);
        this.prefixMap[prefix] = (this.prefixMap[prefix] || 0) + delta;
    }
};

MapSum.prototype.sum = function(prefix) {
    return this.prefixMap[prefix] || 0;
};