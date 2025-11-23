class SegmentTree {
    constructor(n) {
        this.n = n;
        this.tree = new Array(2 * n).fill(Infinity);
    }

    update(idx, val) {
        idx += this.n;
        this.tree[idx] = val;
        while (idx > 1) {
            this.tree[idx >> 1] = Math.min(this.tree[idx], this.tree[idx ^ 1]);
            idx >>= 1;
        }
    }

    query(left, right) { // inclusive [left, right]
        let res = Infinity;
        left += this.n;
        right += this.n;
        while (left <= right) {
            if (left & 1) {
                res = Math.min(res, this.tree[left]);
                left++;
            }
            if (!(right & 1)) {
                res = Math.min(res, this.tree[right]);
                right--;
            }
            left >>= 1;
            right >>= 1;
        }
        return res;
    }
}

var closestEqualElementQueries = function(nums, queries) {
    const n = nums.length;
    const q = queries.length;

    const indexedQueries = [];
    for (let i = 0; i < q; i++) {
        indexedQueries.push({ left: queries[i][0], right: queries[i][1], originalIndex: i });
    }

    indexedQueries.sort((a, b) => a.right - b.right);

    const results = new Array(q).fill(-1);
    const segmentTree = new SegmentTree(n);
    const lastPos = new Map();

    let queryPointer = 0;

    for (let i = 0; i < n; i++) {
        const num = nums[i];

        if (lastPos.has(num)) {
            const prevIdx = lastPos.get(num);
            segmentTree.update(prevIdx, i - prevIdx);
        }
        lastPos.set(num, i);

        while (queryPointer < q && indexedQueries[queryPointer].right === i) {
            const currentQuery = indexedQueries[queryPointer];
            const queryLeft = currentQuery.left;
            const queryRight = currentQuery.right;
            const originalIndex = currentQuery.originalIndex;

            if (queryLeft <= queryRight - 1) {
                const minDistance = segmentTree.query(queryLeft, queryRight - 1);
                if (minDistance !== Infinity) {
                    results[originalIndex] = minDistance;
                }
            }
            queryPointer++;
        }
    }

    return results;
};