class MapSum {
    constructor() {
        this.map = new Map();
        this.prefixMap = new Map();
    }

    insert(key, val) {
        const delta = val - (this.map.get(key) || 0);
        this.map.set(key, val);
        for (let i = 1; i <= key.length; i++) {
            const prefix = key.slice(0, i);
            this.prefixMap.set(prefix, (this.prefixMap.get(prefix) || 0) + delta);
        }
    }

    sum(prefix) {
        return this.prefixMap.get(prefix) || 0;
    }
}