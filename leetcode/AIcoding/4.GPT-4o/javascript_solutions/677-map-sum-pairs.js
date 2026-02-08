class MapSum {
    constructor() {
        this.map = new Map();
        this.root = {};
    }

    insert(key, val) {
        let node = this.root;
        for (const char of key) {
            if (!node[char]) {
                node[char] = {};
            }
            node = node[char];
        }
        this.map.set(key, val);
    }

    sum(prefix) {
        let node = this.root;
        for (const char of prefix) {
            if (!node[char]) {
                return 0;
            }
            node = node[char];
        }
        let total = 0;
        for (const [key, val] of this.map) {
            if (key.startsWith(prefix)) {
                total += val;
            }
        }
        return total;
    }
}