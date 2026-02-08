var FrequencyTracker = function() {
    this.numCounts = new Map();
    this.freqCounts = new Map();
};

FrequencyTracker.prototype.add = function(number) {
    const oldFreq = this.numCounts.get(number) || 0;
    const newFreq = oldFreq + 1;

    this.numCounts.set(number, newFreq);

    if (oldFreq > 0) {
        this.freqCounts.set(oldFreq, this.freqCounts.get(oldFreq) - 1);
        if (this.freqCounts.get(oldFreq) === 0) {
            this.freqCounts.delete(oldFreq);
        }
    }

    this.freqCounts.set(newFreq, (this.freqCounts.get(newFreq) || 0) + 1);
};

FrequencyTracker.prototype.deleteOne = function(number) {
    const oldFreq = this.numCounts.get(number);

    if (oldFreq === undefined || oldFreq === 0) {
        return;
    }

    const newFreq = oldFreq - 1;

    if (newFreq === 0) {
        this.numCounts.delete(number);
    } else {
        this.numCounts.set(number, newFreq);
    }

    this.freqCounts.set(oldFreq, this.freqCounts.get(oldFreq) - 1);
    if (this.freqCounts.get(oldFreq) === 0) {
        this.freqCounts.delete(oldFreq);
    }

    if (newFreq > 0) {
        this.freqCounts.set(newFreq, (this.freqCounts.get(newFreq) || 0) + 1);
    }
};

FrequencyTracker.prototype.hasFrequency = function(frequency) {
    return (this.freqCounts.get(frequency) || 0) > 0;
};