class LFUCache {
    constructor(capacity) {
        this.capacity = capacity;
        this.cache = new Map();
        this.freqMap = new Map();
        this.minFreq = 0;
    }

    get(key) {
        if (!this.cache.has(key)) {
            return -1;
        }

        const freq = this.cache.get(key).freq;
        this.updateFreq(key, freq);

        return this.cache.get(key).value;
    }

    put(key, value) {
        if (this.capacity <= 0) {
            return;
        }

        if (this.cache.has(key)) {
            const freq = this.cache.get(key).freq;
            this.cache.set(key, { value: value, freq: freq });
            this.updateFreq(key, freq);
            return;
        }

        if (this.cache.size >= this.capacity) {
            this.evict();
        }

        this.cache.set(key, { value: value, freq: 1 });
        if (!this.freqMap.has(1)) {
            this.freqMap.set(1, new Set());
        }
        this.freqMap.get(1).add(key);
        this.minFreq = 1;
    }

    updateFreq(key, freq) {
        this.freqMap.get(freq).delete(key);
        if (this.freqMap.get(freq).size === 0) {
            this.freqMap.delete(freq);
            if (this.minFreq === freq) {
                this.minFreq++;
            }
        }

        const newFreq = freq + 1;
        this.cache.get(key).freq = newFreq;
        if (!this.freqMap.has(newFreq)) {
            this.freqMap.set(newFreq, new Set());
        }
        this.freqMap.get(newFreq).add(key);
    }

    evict() {
        const keys = this.freqMap.get(this.minFreq);
        const keyToDelete = keys.values().next().value;
        keys.delete(keyToDelete);

        if (keys.size === 0) {
            this.freqMap.delete(this.minFreq);
        }

        this.cache.delete(keyToDelete);
    }
}