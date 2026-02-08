var FreqStack = function() {
    this.freq = new Map();
    this.stacks = new Map();
    this.maxFreq = 0;
};

FreqStack.prototype.push = function(val) {
    let currentFreq = (this.freq.get(val) || 0) + 1;
    this.freq.set(val, currentFreq);

    if (currentFreq > this.maxFreq) {
        this.maxFreq = currentFreq;
    }

    if (!this.stacks.has(currentFreq)) {
        this.stacks.set(currentFreq, []);
    }
    this.stacks.get(currentFreq).push(val);
};

FreqStack.prototype.pop = function() {
    let valToPop = this.stacks.get(this.maxFreq).pop();

    this.freq.set(valToPop, this.freq.get(valToPop) - 1);

    if (this.stacks.get(this.maxFreq).length === 0) {
        this.maxFreq--;
    }

    return valToPop;
};