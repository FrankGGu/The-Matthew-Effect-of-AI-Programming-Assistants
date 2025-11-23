class FindSumPairs {
    constructor(nums1, nums2) {
        this.nums1 = nums1;
        this.nums2 = nums2;
        this.count = new Map();
        for (let num of nums2) {
            this.count.set(num, (this.count.get(num) || 0) + 1);
        }
    }

    add(index, val) {
        let originalVal = this.nums2[index];
        this.count.set(originalVal, this.count.get(originalVal) - 1);
        if (this.count.get(originalVal) === 0) {
            this.count.delete(originalVal);
        }
        this.nums2[index] += val;
        this.count.set(this.nums2[index], (this.count.get(this.nums2[index]) || 0) + 1);
    }

    countPairs(tot) {
        let result = 0;
        for (let num of this.nums1) {
            if (this.count.has(tot - num)) {
                result += this.count.get(tot - num);
            }
        }
        return result;
    }
}