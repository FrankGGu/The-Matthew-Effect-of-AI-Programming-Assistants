class Solution {
    constructor(nRows, nCols) {
        this.nRows = nRows;
        this.nCols = nCols;
        this.totalCells = nRows * nCols;
        this.map = new Map();
        this.count = 0;
    }

    flip() {
        const rand = Math.floor(Math.random() * (this.totalCells - this.count));
        const index = this.map.get(rand) || rand;
        this.map.set(rand, this.map.get(this.totalCells - 1 - this.count) || this.totalCells - 1 - this.count);
        this.count++;
        return [Math.floor(index / this.nCols), index % this.nCols];
    }

    reset() {
        this.map.clear();
        this.count = 0;
        return [this.nRows, this.nCols];
    }
}