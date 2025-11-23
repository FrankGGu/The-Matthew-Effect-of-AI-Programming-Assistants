function lowerBound(arr, target) {
    let low = 0;
    let high = arr.length;
    while (low < high) {
        let mid = Math.floor((low + high) / 2);
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

class SegmentTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(4 * size).fill(0);
    }

    update(node, start, end, idx, val) {
        if (start === end) {
            this.tree[node] = Math.max(this.tree[node], val);
        } else {
            let mid = Math.floor((start + end) / 2);
            if (idx <= mid) {
                this.update(2 * node, start, mid, idx, val);
            } else {
                this.update(2 * node + 1, mid + 1, end, idx, val);
            }
            this.tree[node] = Math.max(this.tree[2 * node], this.tree[2 * node + 1]);
        }
    }

    query(node, start, end, l, r) {
        if (r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return this.tree[node];
        }
        let mid = Math.floor((start + end) / 2);
        let p1 = this.query(2 * node, start, mid, l, r);
        let p2 = this.query(2 * node + 1, mid + 1, end, l, r);
        return Math.max(p1, p2);
    }
}

function maxBalancedSubsequenceSum(nums) {
    const n = nums.length;

    const x_vals_raw = new Set();
    for (let i = 0; i < n; i++) {
        x_vals_raw.add(nums[i] + i);
    }

    const unique_x_vals = Array.from(x_vals_raw).sort((a, b) => a - b);
    const m = unique_x_vals.length;

    const segmentTree = new SegmentTree(m);
    let max_overall_sum = Number.MIN_SAFE_INTEGER;

    for (let i = 0; i < n; i++) {
        const current_x_val = nums[i] + i;

        const idx_current_x_val = lowerBound(unique_x_vals, current_x_val);

        const prev_max_dp = segmentTree.query(1, 0, m - 1, 0, idx_current_x_val);

        const current_dp_sum = nums[i] + Math.max(0, prev_max_dp);

        max_overall_sum = Math.max(max_overall_sum, current_dp_sum);

        segmentTree.update(1, 0, m - 1, idx_current_x_val, current_dp_sum);
    }

    return max_overall_sum;
}