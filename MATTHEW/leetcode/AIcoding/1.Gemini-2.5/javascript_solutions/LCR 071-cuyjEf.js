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
    const target = Math.floor(Math.random() * this.totalSum);

    let left = 0;
    let right = this.prefixSums.length - 1;
    let ans = -1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (this.prefixSums[mid] > target) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
};