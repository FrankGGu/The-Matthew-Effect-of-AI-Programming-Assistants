class MyHashMap {
    constructor() {
        this.map = {};
    }

    put(key, value) {
        this.map[key] = value;
    }

    get(key) {
        return this.map.hasOwnProperty(key) ? this.map[key] : -1;
    }

    remove(key) {
        delete this.map[key];
    }
}