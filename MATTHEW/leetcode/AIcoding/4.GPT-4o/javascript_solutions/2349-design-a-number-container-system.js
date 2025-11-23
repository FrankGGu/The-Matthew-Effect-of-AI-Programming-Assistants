class NumberContainers {
    constructor() {
        this.indexToNum = new Map();
        this.numToIndices = new Map();
    }

    change(num, index) {
        if (this.indexToNum.has(index)) {
            const oldNum = this.indexToNum.get(index);
            if (oldNum !== num) {
                this.numToIndices.get(oldNum).delete(index);
                if (this.numToIndices.get(oldNum).size === 0) {
                    this.numToIndices.delete(oldNum);
                }
            }
        }
        this.indexToNum.set(index, num);
        if (!this.numToIndices.has(num)) {
            this.numToIndices.set(num, new Set());
        }
        this.numToIndices.get(num).add(index);
    }

    find(num) {
        if (!this.numToIndices.has(num)) {
            return -1;
        }
        return Math.min(...this.numToIndices.get(num));
    }
}