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
    let left = 0;
    let right = this.prefixSums.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (target > this.prefixSums[mid]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
};