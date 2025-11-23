var Solution = function(w) {
    this.prefixSums = [];
    let currentSum = 0;
    for (let i = 0; i < w.length; i++) {
        currentSum += w[i];
        this.prefixSums.push(currentSum);
    }
    this.totalSum = currentSum;
};

Solution.prototype.pickIndex = function() {
    const target = Math.floor(Math.random() * this.totalSum) + 1;

    let low = 0;
    let high = this.prefixSums.length - 1;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        if (this.prefixSums[mid] === target) {
            return mid;
        } else if (this.prefixSums[mid] < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return low;
};