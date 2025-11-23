var longestIncreasingSubsequence = function(nums, k) {
    const MAX_VAL = 100000;
    const tree = new Array(4 * (MAX_VAL + 1)).fill(0);

    function update(node, start, end, idx, val) {
        if (start === end) {
            tree[node] = Math.max(tree[node], val);
            return;
        }
        let mid = Math.floor((start + end) / 2);
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
    }

    function query(node, start, end, l, r) {
        if (r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        let mid = Math.floor((start + end) / 2);
        let p1 = query(2 * node, start, mid, l, r);
        let p2 = query(2 * node + 1, mid + 1, end, l, r);
        return Math.max(p1, p2);
    }

    let maxLen = 0;

    for (let num of nums) {
        let leftBound = Math.max(1, num - k);
        let rightBound = num - 1;

        let prevMaxLen = 0;
        if (leftBound <= rightBound) {
            prevMaxLen = query(1, 1, MAX_VAL, leftBound, rightBound);
        }

        let currentLen = 1 + prevMaxLen;

        update(1, 1, MAX_VAL, num, currentLen);

        maxLen = Math.max(maxLen, currentLen);
    }

    return maxLen;
};