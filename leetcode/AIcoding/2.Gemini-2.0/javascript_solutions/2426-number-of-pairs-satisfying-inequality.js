var numberOfPairs = function(nums1, nums2, diff) {
    const n = nums1.length;
    let count = 0;
    const bit = new BinaryIndexedTree(2 * 10000 + 1);

    for (let i = 0; i < n; i++) {
        const val = nums1[i] - nums2[i];
        count += bit.query(val + diff + 10000);
        bit.update(val + 10000, 1);
    }

    return count;
};

class BinaryIndexedTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(size + 1).fill(0);
    }

    update(index, value) {
        index++;
        while (index <= this.size) {
            this.tree[index] += value;
            index += index & -index;
        }
    }

    query(index) {
        let sum = 0;
        while (index > 0) {
            sum += this.tree[index];
            index -= index & -index;
        }
        return sum;
    }
}