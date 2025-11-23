var kSmallestPairs = function(nums1, nums2, k) {
    const minHeap = new MinPriorityQueue();
    const result = [];

    for (let i = 0; i < Math.min(k, nums1.length); i++) {
        minHeap.enqueue([nums1[i] + nums2[0], i, 0]);
    }

    while (k-- > 0 && minHeap.size() > 0) {
        const [sum, i, j] = minHeap.dequeue().element;
        result.push([nums1[i], nums2[j]]);

        if (j + 1 < nums2.length) {
            minHeap.enqueue([nums1[i] + nums2[j + 1], i, j + 1]);
        }
    }

    return result;
};