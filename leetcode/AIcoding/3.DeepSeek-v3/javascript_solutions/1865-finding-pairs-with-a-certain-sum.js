var FindSumPairs = function(nums1, nums2) {
    this.nums1 = nums1;
    this.nums2 = nums2;
    this.freq = {};
    for (const num of nums2) {
        this.freq[num] = (this.freq[num] || 0) + 1;
    }
};

FindSumPairs.prototype.add = function(index, val) {
    const oldVal = this.nums2[index];
    this.freq[oldVal]--;
    if (this.freq[oldVal] === 0) {
        delete this.freq[oldVal];
    }
    this.nums2[index] += val;
    const newVal = this.nums2[index];
    this.freq[newVal] = (this.freq[newVal] || 0) + 1;
};

FindSumPairs.prototype.count = function(tot) {
    let res = 0;
    for (const num of this.nums1) {
        const target = tot - num;
        res += this.freq[target] || 0;
    }
    return res;
};