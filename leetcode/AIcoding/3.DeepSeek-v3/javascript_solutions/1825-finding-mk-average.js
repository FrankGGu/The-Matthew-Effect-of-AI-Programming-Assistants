var MKAverage = function(m, k) {
    this.m = m;
    this.k = k;
    this.queue = [];
    this.sorted = [];
};

MKAverage.prototype.addElement = function(num) {
    if (this.queue.length === this.m) {
        const removed = this.queue.shift();
        const index = binarySearch(this.sorted, removed);
        this.sorted.splice(index, 1);
    }
    this.queue.push(num);
    const index = binarySearch(this.sorted, num);
    this.sorted.splice(index, 0, num);
};

MKAverage.prototype.calculateMKAverage = function() {
    if (this.queue.length < this.m) return -1;
    const sum = this.sorted.slice(this.k, this.sorted.length - this.k).reduce((a, b) => a + b, 0);
    return Math.floor(sum / (this.m - 2 * this.k));
};

function binarySearch(arr, val) {
    let left = 0;
    let right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < val) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}