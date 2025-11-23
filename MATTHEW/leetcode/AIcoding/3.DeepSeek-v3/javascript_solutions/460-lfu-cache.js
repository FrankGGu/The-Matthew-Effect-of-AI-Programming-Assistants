class LFUCache {
    constructor(capacity) {
        this.capacity = capacity;
        this.minFreq = 0;
        this.keyToVal = new Map();
        this.keyToFreq = new Map();
        this.freqToKeys = new Map();
    }

    get(key) {
        if (!this.keyToVal.has(key)) {
            return -1;
        }
        this.increaseFreq(key);
        return this.keyToVal.get(key);
    }

    put(key, value) {
        if (this.capacity <= 0) return;
        if (this.keyToVal.has(key)) {
            this.keyToVal.set(key, value);
            this.increaseFreq(key);
            return;
        }
        if (this.keyToVal.size >= this.capacity) {
            this.removeMinFreqKey();
        }
        this.keyToVal.set(key, value);
        this.keyToFreq.set(key, 1);
        if (!this.freqToKeys.has(1)) {
            this.freqToKeys.set(1, new Set());
        }
        this.freqToKeys.get(1).add(key);
        this.minFreq = 1;
    }

    increaseFreq(key) {
        const freq = this.keyToFreq.get(key);
        this.keyToFreq.set(key, freq + 1);
        this.freqToKeys.get(freq).delete(key);
        if (!this.freqToKeys.has(freq + 1)) {
            this.freqToKeys.set(freq + 1, new Set());
        }
        this.freqToKeys.get(freq + 1).add(key);
        if (this.freqToKeys.get(freq).size === 0 && freq === this.minFreq) {
            this.minFreq++;
        }
    }

    removeMinFreqKey() {
        const keyList = this.freqToKeys.get(this.minFreq);
        const deletedKey = keyList.values().next().value;
        keyList.delete(deletedKey);
        if (keyList.size === 0) {
            this.freqToKeys.delete(this.minFreq);
        }
        this.keyToVal.delete(deletedKey);
        this.keyToFreq.delete(deletedKey);
    }
}