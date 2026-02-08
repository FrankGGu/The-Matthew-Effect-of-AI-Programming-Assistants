class MapSum {
    constructor() {
        this.map = {};
    }

    insert(key, val) {
        this.map[key] = val;
    }

    sum(prefix) {
        let sum = 0;
        for (let key in this.map) {
            if (key.startsWith(prefix)) {
                sum += this.map[key];
            }
        }
        return sum;
    }
}