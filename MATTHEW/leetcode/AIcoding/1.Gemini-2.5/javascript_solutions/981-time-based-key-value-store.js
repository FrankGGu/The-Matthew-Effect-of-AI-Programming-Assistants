var TimeMap = function() {
    this.map = new Map();
};

TimeMap.prototype.set = function(key, value, timestamp) {
    if (!this.map.has(key)) {
        this.map.set(key, []);
    }
    this.map.get(key).push([timestamp, value]);
};

TimeMap.prototype.get = function(key, timestamp) {
    if (!this.map.has(key)) {
        return "";
    }

    const list = this.map.get(key);
    let low = 0;
    let high = list.length - 1;
    let result = "";

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let [currentTs, currentValue] = list[mid];

        if (currentTs <= timestamp) {
            result = currentValue;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return result;
};