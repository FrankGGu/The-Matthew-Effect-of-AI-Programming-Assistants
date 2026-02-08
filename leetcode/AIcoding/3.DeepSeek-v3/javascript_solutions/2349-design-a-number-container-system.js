var NumberContainers = function() {
    this.indexToNumber = new Map();
    this.numberToIndices = new Map();
};

NumberContainers.prototype.change = function(index, number) {
    if (this.indexToNumber.has(index)) {
        const oldNumber = this.indexToNumber.get(index);
        const indicesSet = this.numberToIndices.get(oldNumber);
        indicesSet.delete(index);
        if (indicesSet.size === 0) {
            this.numberToIndices.delete(oldNumber);
        }
    }
    this.indexToNumber.set(index, number);
    if (!this.numberToIndices.has(number)) {
        this.numberToIndices.set(number, new Set());
    }
    this.numberToIndices.get(number).add(index);
};

NumberContainers.prototype.find = function(number) {
    if (!this.numberToIndices.has(number) || this.numberToIndices.get(number).size === 0) {
        return -1;
    }
    return Math.min(...this.numberToIndices.get(number));
};