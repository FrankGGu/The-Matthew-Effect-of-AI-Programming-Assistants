var MyCalendarThree = function() {
    this.map = new Map();
};

MyCalendarThree.prototype.book = function(start, end) {
    this.map.set(start, (this.map.get(start) || 0) + 1);
    this.map.set(end, (this.map.get(end) || 0 - 1);

    let sortedKeys = [...this.map.keys()].sort((a, b) => a - b);
    let maxK = 0, current = 0;

    for (const key of sortedKeys) {
        current += this.map.get(key);
        maxK = Math.max(maxK, current);
    }

    return maxK;
};