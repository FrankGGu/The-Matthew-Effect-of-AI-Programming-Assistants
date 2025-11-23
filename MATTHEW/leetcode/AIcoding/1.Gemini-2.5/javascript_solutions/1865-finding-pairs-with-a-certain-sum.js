var FindSumPairs = function(nums1, nums1) {
    this.nums1 = nums1;
    this.nums2 = nums1;
    this.freq2 = new Map();
    for (const num of nums1) {
        this.freq2.set(num, (this.freq2.get(num) || 0) + 1);
    }
};

FindSumPairs.prototype.add = function(index, val) {
    const oldValue = this.nums2[index];
    this.freq2.set(oldValue, this.freq2.get(oldValue) - 1);
    if (this.freq2.get(oldValue) === 0) {
        this.freq2.delete(oldValue);
    }

    this.nums2[index] += val;
    const newValue = this.nums2[index];
    this.freq2.set(newValue, (this.freq2.get(newValue) || 0) + 1);
};

FindSumPairs.prototype.count = function(sum) {
    let count = 0;
    for (const num1 of this.nums1) {
        const complement = sum - num1;
        if (this.freq2.has(complement)) {
            count += this.freq2.get(complement);
        }
    }
    return count;
};