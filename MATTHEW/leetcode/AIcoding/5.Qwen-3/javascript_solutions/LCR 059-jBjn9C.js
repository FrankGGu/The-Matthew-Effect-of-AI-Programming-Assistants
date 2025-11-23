var KthLargest = function (k, nums) {
    this.k = k;
    this.heap = [];
    for (let num of nums) {
        this.add(num);
    }
};

KthLargest.prototype.add = function (val) {
    this.heap.push(val);
    let i = this.heap.length - 1;
    while (i > 0) {
        let parent = Math.floor((i - 1) / 2);
        if (this.heap[parent] >= this.heap[i]) break;
        [this.heap[parent], this.heap[i]] = [this.heap[i], this.heap[parent]];
        i = parent;
    }
    if (this.heap.length > this.k) {
        this.heap[0] = this.heap[this.heap.length - 1];
        this.heap.pop();
        let i = 0;
        while (true) {
            let left = 2 * i + 1;
            let right = 2 * i + 2;
            let max = i;
            if (left < this.heap.length && this.heap[left] > this.heap[max]) max = left;
            if (right < this.heap.length && this.heap[right] > this.heap[max]) max = right;
            if (max === i) break;
            [this.heap[i], this.heap[max]] = [this.heap[max], this.heap[i]];
            i = max;
        }
    }
    return this.heap[0];
};