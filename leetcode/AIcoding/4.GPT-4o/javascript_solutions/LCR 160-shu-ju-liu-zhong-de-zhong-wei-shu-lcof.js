class MedianFinder {
    constructor() {
        this.minHeap = [];
        this.maxHeap = [];
    }

    addNum(num) {
        this.maxHeap.push(num);
        this.maxHeap.sort((a, b) => b - a);

        if (this.maxHeap.length > this.minHeap.length + 1) {
            this.minHeap.push(this.maxHeap.shift());
            this.minHeap.sort((a, b) => a - b);
        }

        if (this.minHeap.length > 0 && this.maxHeap[0] > this.minHeap[0]) {
            const temp = this.maxHeap.shift();
            this.maxHeap.unshift(this.minHeap.shift());
            this.minHeap.unshift(temp);
        }
    }

    findMedian() {
        if (this.maxHeap.length > this.minHeap.length) {
            return this.maxHeap[0];
        }
        return (this.maxHeap[0] + this.minHeap[0]) / 2;
    }
}