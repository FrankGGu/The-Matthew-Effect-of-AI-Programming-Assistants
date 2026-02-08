class MKAverage {
    constructor(m, k) {
        this.m = m;
        this.k = k;
        this.queue = [];
        this.validElements = [];
    }

    addElement(num) {
        if (this.queue.length === this.m) {
            const removed = this.queue.shift();
            const index = this.validElements.indexOf(removed);
            if (index !== -1) {
                this.validElements.splice(index, 1);
            }
        }
        this.queue.push(num);
        if (this.queue.length >= this.m - this.k * 2) {
            this.validElements.push(num);
            this.validElements.sort((a, b) => a - b);
        }
    }

    calculateMKAverage() {
        if (this.queue.length < this.m) {
            return -1;
        }
        return this.validElements.slice(this.k, this.validElements.length - this.k).reduce((sum, num) => sum + num, 0) / (this.m - 2 * this.k);
    }
}