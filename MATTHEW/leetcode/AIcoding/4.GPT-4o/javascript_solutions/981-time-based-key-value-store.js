class TimeMap {
    constructor() {
        this.map = {};
    }

    set(key, value, timestamp) {
        if (!this.map[key]) {
            this.map[key] = [];
        }
        this.map[key].push([timestamp, value]);
    }

    get(key, timestamp) {
        if (!this.map[key]) return "";
        const values = this.map[key];
        let left = 0, right = values.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (values[mid][0] <= timestamp) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return right >= 0 ? values[right][1] : "";
    }
}