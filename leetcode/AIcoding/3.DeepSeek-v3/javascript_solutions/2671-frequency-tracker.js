var FrequencyTracker = function() {
    this.freqMap = new Map();
    this.numMap = new Map();
};

FrequencyTracker.prototype.add = function(number) {
    if (this.numMap.has(number)) {
        const oldFreq = this.numMap.get(number);
        this.freqMap.set(oldFreq, (this.freqMap.get(oldFreq) || 0) - 1);
        if (this.freqMap.get(oldFreq) <= 0) {
            this.freqMap.delete(oldFreq);
        }
        const newFreq = oldFreq + 1;
        this.numMap.set(number, newFreq);
        this.freqMap.set(newFreq, (this.freqMap.get(newFreq) || 0) + 1);
    } else {
        this.numMap.set(number, 1);
        this.freqMap.set(1, (this.freqMap.get(1) || 0) + 1);
    }
};

FrequencyTracker.prototype.deleteOne = function(number) {
    if (this.numMap.has(number)) {
        const oldFreq = this.numMap.get(number);
        this.freqMap.set(oldFreq, (this.freqMap.get(oldFreq) || 0) - 1);
        if (this.freqMap.get(oldFreq) <= 0) {
            this.freqMap.delete(oldFreq);
        }
        if (oldFreq === 1) {
            this.numMap.delete(number);
        } else {
            const newFreq = oldFreq - 1;
            this.numMap.set(number, newFreq);
            this.freqMap.set(newFreq, (this.freqMap.get(newFreq) || 0) + 1);
        }
    }
};

FrequencyTracker.prototype.hasFrequency = function(frequency) {
    return this.freqMap.has(frequency) && this.freqMap.get(frequency) > 0;
};