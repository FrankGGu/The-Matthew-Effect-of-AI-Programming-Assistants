class Solution {
    constructor(w) {
        this.prefixSums = [];
        this.total = 0;
        for (let weight of w) {
            this.total += weight;
            this.prefixSums.push(this.total);
        }
    }

    pickIndex() {
        const target = Math.random() * this.total;
        let left = 0, right = this.prefixSums.length - 1;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (this.prefixSums[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}