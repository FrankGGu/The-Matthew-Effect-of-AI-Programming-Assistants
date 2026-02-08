class SegmentTreeNode {
    constructor(start, end) {
        this.start = start;
        this.end = end;
        this.left = null;
        this.right = null;
        this.val = 0;
        this.lazy = 0;
    }
}

class SegmentTree {
    constructor(nums) {
        this.root = this.build(nums, 0, nums.length - 1);
    }

    build(nums, start, end) {
        let node = new SegmentTreeNode(start, end);
        if (start === end) {
            node.val = nums[start];
            return node;
        }
        let mid = Math.floor((start + end) / 2);
        node.left = this.build(nums, start, mid);
        node.right = this.build(nums, mid + 1, end);
        node.val = node.left.val + node.right.val;
        return node;
    }

    updateRange(node, l, r) {
        if (node.end < l || node.start > r) {
            return;
        }
        if (l <= node.start && node.end <= r) {
            node.val = (node.end - node.start + 1) - node.val;
            node.lazy ^= 1;
            return;
        }
        this.pushDown(node);
        this.updateRange(node.left, l, r);
        this.updateRange(node.right, l, r);
        node.val = node.left.val + node.right.val;
    }

    pushDown(node) {
        if (node.lazy !== 0) {
            node.left.val = (node.left.end - node.left.start + 1) - node.left.val;
            node.left.lazy ^= 1;
            node.right.val = (node.right.end - node.right.start + 1) - node.right.val;
            node.right.lazy ^= 1;
            node.lazy = 0;
        }
    }

    queryRange(node, l, r) {
        if (node.end < l || node.start > r) {
            return 0;
        }
        if (l <= node.start && node.end <= r) {
            return node.val;
        }
        this.pushDown(node);
        return this.queryRange(node.left, l, r) + this.queryRange(node.right, l, r);
    }
}

var handleQuery = function(nums1, nums2, queries) {
    const st = new SegmentTree(nums1);
    let sum = nums2.reduce((a, b) => a + b, 0);
    const res = [];
    for (const query of queries) {
        if (query[0] === 1) {
            st.updateRange(st.root, query[1], query[2]);
        } else if (query[0] === 2) {
            const cnt = st.queryRange(st.root, 0, nums1.length - 1);
            sum += query[1] * cnt;
        } else if (query[0] === 3) {
            res.push(sum);
        }
    }
    return res;
};