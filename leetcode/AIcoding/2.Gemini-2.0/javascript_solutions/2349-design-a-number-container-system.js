class NumberContainers {
    constructor() {
        this.indexMap = new Map();
        this.numberMap = new Map();
    }

    change(index, number) {
        if (this.indexMap.has(index)) {
            const prevNumber = this.indexMap.get(index);
            const indexSet = this.numberMap.get(prevNumber);
            indexSet.delete(index);
            if (indexSet.size === 0) {
                this.numberMap.delete(prevNumber);
            }
        }
        this.indexMap.set(index, number);
        if (!this.numberMap.has(number)) {
            this.numberMap.set(number, new Set());
        }
        this.numberMap.get(number).add(index);
    }

    find(number) {
        if (!this.numberMap.has(number)) {
            return -1;
        }
        let minIndex = Infinity;
        for (const index of this.numberMap.get(number)) {
            minIndex = Math.min(minIndex, index);
        }
        return minIndex;
    }
}