class KthLargest {
    constructor(k, nums) {
        this.k = k;
        this.minHeap = [];
        for (let num of nums) {
            this.add(num);
        }
    }

    add(val) {
        this.minHeap.push(val);
        this.minHeap.sort((a, b) => a - b);
        if (this.minHeap.length > this.k) {
            this.minHeap.shift();
        }
        return this.minHeap[0];
    }
}