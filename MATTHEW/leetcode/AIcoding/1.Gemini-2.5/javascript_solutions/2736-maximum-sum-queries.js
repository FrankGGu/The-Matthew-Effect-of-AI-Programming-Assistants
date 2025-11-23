class SegmentTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(4 * size).fill(-1);
    }

    update(node, start, end, idx, val) {
        if (start === end) {
            this.tree[node] = Math.max(this.tree[node], val);
            return;
        }
        let mid = Math.floor((start + end) / 2);
        if (idx <= mid) {
            this.update(2 * node, start, mid, idx, val);
        } else {
            this.update(2 * node + 1, mid + 1, end, idx, val);
        }
        this.tree[node] = Math.max(this.tree[2 * node], this.tree[2 * node + 1]);
    }

    query(node, start, end, l, r) {
        if (r < start || end < l || l > r) {
            return -1;
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

function lowerBound(arr, val) {
    let low = 0, high = arr.length - 1, ans = arr.length;
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (arr[mid] >= val) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

var maximumSumQueries = function(nums1, nums2, queries) {
    const n = nums1.length;
    const q = queries.length;

    const data = [];
    for (let i = 0; i < n; i++) {
        data.push([nums1[i], nums2[i]]);
    }

    const queryData = [];
    for (let i = 0; i < q; i++) {
        queryData.push([queries[i][0], queries[i][1], i]);
    }

    data.sort((a, b) => b[0] - a[0]);

    queryData.sort((a, b) => b[0] - a[0]);

    const allYValues = new Set();
    for (const [_, num2] of data) {
        allYValues.add(num2);
    }
    for (const [_, y, __] of queryData) {
        allYValues.add(y);
    }
    const compressedCoords = Array.from(allYValues).sort((a, b) => a - b);
    const coordMap = new Map();
    for (let i = 0; i < compressedCoords.length; i++) {
        coordMap.set(compressedCoords[i], i);
    }

    const segmentTreeSize = compressedCoords.length;
    const st = new SegmentTree(segmentTreeSize);

    const results = new Array(q).fill(-1);
    let dataPointer = 0;

    for (const [x, y, originalIndex] of queryData) {
        while (dataPointer < n && data[dataPointer][0] >= x) {
            const [num1, num2] = data[dataPointer];
            const compressedNum2Index = coordMap.get(num2);
            st.update(1, 0, segmentTreeSize - 1, compressedNum2Index, num1 + num2);
            dataPointer++;
        }

        const minYIndex = lowerBound(compressedCoords, y);
        if (minYIndex < segmentTreeSize) {
            results[originalIndex] = st.query(1, 0, segmentTreeSize - 1, minYIndex, segmentTreeSize - 1);
        }
    }

    return results;
};