class FreqStack {
    constructor() {
        this.freqMap = new Map();
        this.maxFreq = 0;
        this.group = new Map();
    }

    push(val) {
        const freq = (this.freqMap.get(val) || 0) + 1;
        this.freqMap.set(val, freq);
        this.maxFreq = Math.max(this.maxFreq, freq);
        if (!this.group.has(freq)) {
            this.group.set(freq, []);
        }
        this.group.get(freq).push(val);
    }

    pop() {
        const x = this.group.get(this.maxFreq).pop();
        this.freqMap.set(x, this.freqMap.get(x) - 1);
        if (this.group.get(this.maxFreq).length === 0) {
            this.maxFreq--;
        }
        return x;
    }
}