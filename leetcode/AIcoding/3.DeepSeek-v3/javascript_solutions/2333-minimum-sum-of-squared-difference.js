var minSumSquareDiff = function(nums1, nums2, k1, k2) {
    const n = nums1.length;
    const diffs = new Array(n);
    for (let i = 0; i < n; i++) {
        diffs[i] = Math.abs(nums1[i] - nums2[i]);
    }
    const maxHeap = new MaxPriorityQueue();
    for (const diff of diffs) {
        if (diff > 0) {
            maxHeap.enqueue(diff);
        }
    }
    let k = k1 + k2;
    if (k <= 0) {
        return diffs.reduce((sum, diff) => sum + diff * diff, 0);
    }
    while (k > 0 && !maxHeap.isEmpty()) {
        let current = maxHeap.dequeue().element;
        let next = maxHeap.isEmpty() ? 0 : maxHeap.front().element;
        let diff = current - next;
        let count = 1;
        while (!maxHeap.isEmpty() && maxHeap.front().element === next) {
            maxHeap.dequeue();
            count++;
        }
        let maxReduce = Math.min(k, diff * count);
        let reducePerNum = Math.floor(maxReduce / count);
        let remainder = maxReduce % count;
        for (let i = 0; i < count; i++) {
            let newDiff = current - reducePerNum - (i < remainder ? 1 : 0);
            if (newDiff > 0) {
                maxHeap.enqueue(newDiff);
            }
        }
        k -= maxReduce;
    }
    let sum = 0;
    while (!maxHeap.isEmpty()) {
        const diff = maxHeap.dequeue().element;
        sum += diff * diff;
    }
    return sum;
};