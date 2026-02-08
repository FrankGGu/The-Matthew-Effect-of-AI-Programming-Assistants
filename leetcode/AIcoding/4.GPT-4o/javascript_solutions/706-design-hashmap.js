class MyHashMap {
    constructor() {
        this.map = new Array(1000001).fill(-1);
    }

    put(key, value) {
        this.map[key] = value;
    }

    get(key) {
        return this.map[key];
    }

    remove(key) {
        this.map[key] = -1;
    }
}