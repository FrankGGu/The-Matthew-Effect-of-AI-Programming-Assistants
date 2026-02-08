class FrequencyTracker {
    constructor() {
        this.freq = new Map();
        this.count = new Map();
    }

    add(number) {
        if (this.freq.has(number)) {
            this.count.set(this.freq.get(number), this.count.get(this.freq.get(number)) - 1);
            if (this.count.get(this.freq.get(number)) === 0) {
                this.count.delete(this.freq.get(number));
            }
        }
        this.freq.set(number, (this.freq.get(number) || 0) + 1);
        this.count.set(this.freq.get(number), (this.count.get(this.freq.get(number)) || 0) + 1);
    }

    deleteOne(number) {
        if (this.freq.has(number)) {
            this.count.set(this.freq.get(number), this.count.get(this.freq.get(number)) - 1);
            if (this.count.get(this.freq.get(number)) === 0) {
                this.count.delete(this.freq.get(number));
            }
            this.freq.set(number, this.freq.get(number) - 1);
            if (this.freq.get(number) === 0) {
                this.freq.delete(number);
            }
        }
    }

    hasFrequency(frequency) {
        return this.count.has(frequency);
    }
}