class MyHashMap {
    constructor() {
        this.size = 769;
        this.table = new Array(this.size).fill(null);
    }

    hash(key) {
        return key % this.size;
    }

    put(key, value) {
        const index = this.hash(key);
        if (!this.table[index]) {
            this.table[index] = [[key, value]];
        } else {
            for (let i = 0; i < this.table[index].length; i++) {
                if (this.table[index][i][0] === key) {
                    this.table[index][i][1] = value;
                    return;
                }
            }
            this.table[index].push([key, value]);
        }
    }

    get(key) {
        const index = this.hash(key);
        if (!this.table[index]) {
            return -1;
        } else {
            for (let i = 0; i < this.table[index].length; i++) {
                if (this.table[index][i][0] === key) {
                    return this.table[index][i][1];
                }
            }
            return -1;
        }
    }

    remove(key) {
        const index = this.hash(key);
        if (this.table[index]) {
            for (let i = 0; i < this.table[index].length; i++) {
                if (this.table[index][i][0] === key) {
                    this.table[index].splice(i, 1);
                    if (this.table[index].length === 0) {
                        this.table[index] = null;
                    }
                    return;
                }
            }
        }
    }
}