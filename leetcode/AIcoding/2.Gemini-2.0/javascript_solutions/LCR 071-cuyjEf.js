var Solution = function(w) {
    this.prefixSums = [];
    let prefixSum = 0;
    for (let weight of w) {
        prefixSum += weight;
        this.prefixSums.push(prefixSum);
    }
    this.totalSum = prefixSum;
};

Solution.prototype.pickIndex = function() {
    const target = Math.random() * this.totalSum;
    let low = 0;
    let high = this.prefixSums.length - 1;
    while (low < high) {
        const mid = Math.floor((low + high) / 2);
        if (target > this.prefixSums[mid]) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
};