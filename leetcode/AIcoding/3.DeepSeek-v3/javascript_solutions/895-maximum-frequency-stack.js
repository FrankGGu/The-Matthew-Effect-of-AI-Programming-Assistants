var FreqStack = function() {
    this.freq = new Map();
    this.group = new Map();
    this.maxFreq = 0;
};

FreqStack.prototype.push = function(val) {
    const f = (this.freq.get(val) || 0) + 1;
    this.freq.set(val, f);
    if (f > this.maxFreq) {
        this.maxFreq = f;
    }
    if (!this.group.has(f)) {
        this.group.set(f, []);
    }
    this.group.get(f).push(val);
};

FreqStack.prototype.pop = function() {
    const val = this.group.get(this.maxFreq).pop();
    this.freq.set(val, this.freq.get(val) - 1);
    if (this.group.get(this.maxFreq).length === 0) {
        this.maxFreq--;
    }
    return val;
};