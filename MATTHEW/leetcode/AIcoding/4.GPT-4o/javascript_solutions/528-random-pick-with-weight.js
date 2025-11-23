class Solution {
    constructor(w) {
        this.prefixSums = [];
        let total = 0;
        for (let weight of w) {
            total += weight;
            this.prefixSums.push(total);
        }
        this.totalWeight = total;
    }

    pickIndex() {
        const randomWeight = Math.random() * this.totalWeight;
        let left = 0, right = this.prefixSums.length - 1;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (this.prefixSums[mid] > randomWeight) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }
}