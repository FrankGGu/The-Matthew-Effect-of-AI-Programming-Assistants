class SmallestInfiniteSet {
    constructor() {
        this.minHeap = [];
        this.nextNum = 1;
    }

    popSmallest() {
        if (this.minHeap.length > 0) {
            return this.minHeap.shift();
        } else {
            return this.nextNum++;
        }
    }

    addBack(num) {
        if (num < this.nextNum && !this.minHeap.includes(num)) {
            this.minHeap.push(num);
            this.minHeap.sort((a, b) => a - b);
        }
    }
}