var FrequencyTracker = function() {
    this.freqMap = new Map();
    this.countMap = new Map();
};

FrequencyTracker.prototype.getFrequency = function(key) {
    return this.freqMap.get(key) || 0;
};

FrequencyTracker.prototype.increase = function(key) {
    const currentFreq = this.freqMap.get(key) || 0;
    if (currentFreq > 0) {
        this.countMap.set(currentFreq, this.countMap.get(currentFreq) - 1);
        if (this.countMap.get(currentFreq) === 0) {
            this.countMap.delete(currentFreq);
        }
    }
    const newFreq = currentFreq + 1;
    this.freqMap.set(key, newFreq);
    this.countMap.set(newFreq, (this.countMap.get(newFreq) || 0) + 1);
};

FrequencyTracker.prototype.decrease = function(key) {
    const currentFreq = this.freqMap.get(key) || 0;
    if (currentFreq === 0) return;
    this.countMap.set(currentFreq, this.countMap.get(currentFreq) - 1);
    if (this.countMap.get(currentFreq) === 0) {
        this.countMap.delete(currentFreq);
    }
    const newFreq = currentFreq - 1;
    if (newFreq > 0) {
        this.freqMap.set(key, newFreq);
        this.countMap.set(newFreq, (this.countMap.get(newFreq) || 0) + 1);
    } else {
        this.freqMap.delete(key);
    }
};

FrequencyTracker.prototype.hasFrequency = function(freq) {
    return this.countMap.has(freq);
};