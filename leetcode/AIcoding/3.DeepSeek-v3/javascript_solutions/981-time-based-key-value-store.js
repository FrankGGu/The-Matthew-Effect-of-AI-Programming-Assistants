var TimeMap = function() {
    this.map = new Map();
};

TimeMap.prototype.set = function(key, value, timestamp) {
    if (!this.map.has(key)) {
        this.map.set(key, []);
    }
    this.map.get(key).push({ timestamp, value });
};

TimeMap.prototype.get = function(key, timestamp) {
    if (!this.map.has(key)) {
        return "";
    }
    const entries = this.map.get(key);
    let left = 0, right = entries.length - 1;
    let result = "";
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (entries[mid].timestamp <= timestamp) {
            result = entries[mid].value;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
};