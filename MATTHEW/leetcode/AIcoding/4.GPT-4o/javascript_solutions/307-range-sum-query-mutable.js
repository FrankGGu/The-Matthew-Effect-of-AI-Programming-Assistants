class NumArray {
    constructor(nums) {
        this.nums = nums;
        this.n = nums.length;
        this.tree = new Array(this.n * 2);
        for (let i = 0; i < this.n; i++) {
            this.tree[i + this.n] = nums[i];
        }
        for (let i = this.n - 1; i > 0; i--) {
            this.tree[i] = this.tree[i * 2] + this.tree[i * 2 + 1];
        }
    }

    update(index, val) {
        index += this.n;
        this.tree[index] = val;
        while (index > 1) {
            index >>= 1;
            this.tree[index] = this.tree[index * 2] + this.tree[index * 2 + 1];
        }
    }

    sumRange(left, right) {
        left += this.n;
        right += this.n;
        let sum = 0;
        while (left <= right) {
            if (left % 2 === 1) {
                sum += this.tree[left];
                left++;
            }
            if (right % 2 === 0) {
                sum += this.tree[right];
                right--;
            }
            left >>= 1;
            right >>= 1;
        }
        return sum;
    }
}