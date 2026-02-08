class FrequencyTracker {
    constructor() {
        this.nums = {};
        this.freq = {};
    }

    add(number) {
        if (this.nums[number] === undefined) {
            this.nums[number] = 0;
        }
        let oldFreq = this.nums[number];
        if (oldFreq > 0) {
            this.freq[oldFreq]--;
            if (this.freq[oldFreq] === 0) {
                delete this.freq[oldFreq];
            }
        }
        this.nums[number]++;
        let newFreq = this.nums[number];
        if (this.freq[newFreq] === undefined) {
            this.freq[newFreq] = 0;
        }
        this.freq[newFreq]++;
    }

    delete(number) {
        if (this.nums[number] === undefined || this.nums[number] === 0) {
            return;
        }
        let oldFreq = this.nums[number];
        this.freq[oldFreq]--;
        if (this.freq[oldFreq] === 0) {
            delete this.freq[oldFreq];
        }
        this.nums[number]--;
        if (this.nums[number] === 0) {
            delete this.nums[number];
            return;
        }
        let newFreq = this.nums[number];
        if (this.freq[newFreq] === undefined) {
            this.freq[newFreq] = 0;
        }
        this.freq[newFreq]++;
    }

    hasFrequency(frequency) {
        return this.freq[frequency] !== undefined;
    }
}