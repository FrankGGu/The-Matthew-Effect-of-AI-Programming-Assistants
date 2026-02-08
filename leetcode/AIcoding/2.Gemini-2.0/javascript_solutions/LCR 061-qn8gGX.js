var kSmallestPairs = function(nums1, nums2, k) {
    const minHeap = new MinPriorityQueue({ priority: x => x[0] + x[1] });
    const result = [];

    for (let i = 0; i < Math.min(nums1.length, k); i++) {
        minHeap.enqueue([nums1[i], nums2[0], 0]);
    }

    while (k > 0 && !minHeap.isEmpty()) {
        const [num1, num2, nums2Index] = minHeap.dequeue().element;
        result.push([num1, num2]);
        k--;

        if (nums2Index + 1 < nums2.length) {
            minHeap.enqueue([num1, nums2[nums2Index + 1], nums2Index + 1]);
        }
    }

    return result;
};