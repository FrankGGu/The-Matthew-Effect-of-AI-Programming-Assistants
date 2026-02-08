class NumArray {
    constructor(nums) {
        this.nums = nums;
        this.size = nums.length;
        this.tree = new Array(this.size + 1).fill(0);
        for (let i = 0; i < this.size; i++) {
            this.updateTree(i, nums[i]);
        }
    }

    updateTree(index, delta) {
        index += 1;
        while (index <= this.size) {
            this.tree[index] += delta;
            index += index & -index;
        }
    }

    query(index) {
        let res = 0;
        index += 1;
        while (index > 0) {
            res += this.tree[index];
            index -= index & -index;
        }
        return res;
    }

    update(index, val) {
        const delta = val - this.nums[index];
        this.nums[index] = val;
        this.updateTree(index, delta);
    }

    sumRange(left, right) {
        return this.query(right) - this.query(left - 1);
    }
}