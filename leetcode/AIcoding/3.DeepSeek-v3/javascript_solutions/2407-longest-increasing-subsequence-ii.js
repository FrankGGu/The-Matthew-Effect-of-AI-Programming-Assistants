class SegmentTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(4 * size).fill(0);
    }

    update(index, value, node = 1, nodeLeft = 0, nodeRight = null) {
        if (nodeRight === null) nodeRight = this.size - 1;
        if (nodeLeft === nodeRight) {
            this.tree[node] = value;
            return;
        }
        const mid = Math.floor((nodeLeft + nodeRight) / 2);
        if (index <= mid) {
            this.update(index, value, 2 * node, nodeLeft, mid);
        } else {
            this.update(index, value, 2 * node + 1, mid + 1, nodeRight);
        }
        this.tree[node] = Math.max(this.tree[2 * node], this.tree[2 * node + 1]);
    }

    queryRange(left, right, node = 1, nodeLeft = 0, nodeRight = null) {
        if (nodeRight === null) nodeRight = this.size - 1;
        if (right < nodeLeft || left > nodeRight) return 0;
        if (left <= nodeLeft && nodeRight <= right) return this.tree[node];
        const mid = Math.floor((nodeLeft + nodeRight) / 2);
        return Math.max(
            this.queryRange(left, right, 2 * node, nodeLeft, mid),
            this.queryRange(left, right, 2 * node + 1, mid + 1, nodeRight)
        );
    }
}

var lengthOfLIS = function(nums, k) {
    const maxNum = Math.max(...nums);
    const st = new SegmentTree(maxNum + 1);
    let result = 0;

    for (const num of nums) {
        const left = Math.max(0, num - k);
        const right = num - 1;
        const maxLen = st.queryRange(left, right);
        st.update(num, maxLen + 1);
        result = Math.max(result, maxLen + 1);
    }

    return result;
};