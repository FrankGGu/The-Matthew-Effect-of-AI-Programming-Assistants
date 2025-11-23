var LFUCache = function(capacity) {
    this.capacity = capacity;
    this.cache = new Map();
    this.freqMap = new Map();
    this.minFreq = 1;
};

LFUCache.prototype.get = function(key) {
    if (!this.cache.has(key)) return -1;

    const node = this.cache.get(key);
    const freq = node.freq;

    // Update frequency
    this.removeNodeFromFreqList(node, freq);
    node.freq++;
    this.addToFreqList(node, freq + 1);

    // Check if minFreq needs to be updated
    if (this.freqMap.get(freq).size === 0) {
        this.minFreq = freq + 1;
    }

    return node.value;
};

LFUCache.prototype.put = function(key, value) {
    if (this.capacity === 0) return;

    if (this.cache.has(key)) {
        const node = this.cache.get(key);
        node.value = value;

        const freq = node.freq;
        this.removeNodeFromFreqList(node, freq);
        node.freq++;
        this.addToFreqList(node, freq + 1);

        if (this.freqMap.get(freq).size === 0) {
            this.minFreq = freq + 1;
        }
    } else {
        if (this.cache.size >= this.capacity) {
            const evictNode = this.freqMap.get(this.minFreq).shift();
            this.cache.delete(evictNode.key);
            if (this.freqMap.get(this.minFreq).length === 0) {
                this.freqMap.delete(this.minFreq);
            }
        }

        const newNode = { key, value, freq: 1 };
        this.cache.set(key, newNode);
        this.addToFreqList(newNode, 1);
        this.minFreq = 1;
    }
};

LFUCache.prototype.removeNodeFromFreqList = function(node, freq) {
    const list = this.freqMap.get(freq);
    const index = list.findIndex(n => n.key === node.key);
    if (index !== -1) {
        list.splice(index, 1);
    }

    if (list.length === 0) {
        this.freqMap.delete(freq);
    }
};

LFUCache.prototype.addToFreqList = function(node, freq) {
    if (!this.freqMap.has(freq)) {
        this.freqMap.set(freq, []);
    }
    this.freqMap.get(freq).push(node);
};