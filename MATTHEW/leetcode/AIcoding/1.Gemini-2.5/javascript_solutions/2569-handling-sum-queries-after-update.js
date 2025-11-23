var handleQuery = function(nums1, nums2, queries) {
    const N = nums1.length;

    class Node {
        constructor() {
            this.sumWhenOnes = 0n;
            this.sumWhenZeros = 0n;
            this.countOnes = 0;
            this.countZeros = 0;
            this.lazy = false;
        }
    }

    const tree = new Array(4 * N);

    const merge = (parentIdx, leftIdx, rightIdx) => {
        const leftNode = tree[leftIdx];
        const rightNode = tree[rightIdx];
        const parentNode = tree[parentIdx];

        parentNode.sumWhenOnes = leftNode.sumWhenOnes + rightNode.sumWhenOnes;
        parentNode.sumWhenZeros = leftNode.sumWhenZeros + rightNode.sumWhenZeros;
        parentNode.countOnes = leftNode.countOnes + rightNode.countOnes;
        parentNode.countZeros = leftNode.countZeros + rightNode.countZeros;
    };

    const applyFlip = (nodeIdx) => {
        const node = tree[nodeIdx];
        [node.sumWhenOnes, node.sumWhenZeros] = [node.sumWhenZeros, node.sumWhenOnes];
        [node.countOnes, node.countZeros] = [node.countZeros, node.countOnes];
        node.lazy = !node.lazy;
    };

    const pushDown = (nodeIdx) => {
        const node = tree[nodeIdx];
        if (node.lazy) {
            applyFlip(2 * nodeIdx);
            applyFlip(2 * nodeIdx + 1);
            node.lazy = false;
        }
    };

    const build = (nodeIdx, start, end) => {
        tree[nodeIdx] = new Node();
        if (start === end) {
            if (nums1[start] === 1) {
                tree[nodeIdx].sumWhenOnes = BigInt(nums2[start]);
                tree[nodeIdx].countOnes = 1;
            } else {
                tree[nodeIdx].sumWhenZeros = BigInt(nums2[start]);
                tree[nodeIdx].countZeros = 1;
            }
        } else {
            const mid = Math.floor((start + end) / 2);
            build(2 * nodeIdx, start, mid);
            build(2 * nodeIdx + 1, mid + 1, end);
            merge(nodeIdx, 2 * nodeIdx, 2 * nodeIdx + 1);
        }
    };

    const updateRange = (nodeIdx, start, end, queryL, queryR) => {
        if (queryL <= start && end <= queryR) {
            applyFlip(nodeIdx);
            return;
        }
        if (end < queryL || start > queryR) {
            return;
        }

        pushDown(nodeIdx);
        const mid = Math.floor((start + end) / 2);
        updateRange(2 * nodeIdx, start, mid, queryL, queryR);
        updateRange(2 * nodeIdx + 1, mid + 1, end, queryL, queryR);
        merge(nodeIdx, 2 * nodeIdx, 2 * nodeIdx + 1);
    };

    build(1, 0, N - 1);

    const results = [];
    for (const query of queries) {
        const type = query[0];
        if (type === 0) {
            const l = query[1];
            const r = query[2];
            updateRange(1, 0, N - 1, l, r);
        } else if (type === 1) {
            const x = BigInt(query[1]);
            tree[1].sumWhenOnes += x * BigInt(tree[1].countOnes);
        } else {
            results.push(tree[1].sumWhenOnes);
        }
    }

    return results;
};