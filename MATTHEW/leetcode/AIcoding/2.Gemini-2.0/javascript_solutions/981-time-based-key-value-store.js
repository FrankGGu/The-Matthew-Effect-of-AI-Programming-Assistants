var TimeMap = function() {
    this.map = new Map();
};

TimeMap.prototype.set = function(key, value, timestamp) {
    if (!this.map.has(key)) {
        this.map.set(key, []);
    }
    this.map.get(key).push([value, timestamp]);
};

TimeMap.prototype.get = function(key, timestamp) {
    if (!this.map.has(key)) {
        return "";
    }

    const values = this.map.get(key);
    let left = 0;
    let right = values.length - 1;
    let result = "";

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (values[mid][1] <= timestamp) {
            result = values[mid][0];
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};