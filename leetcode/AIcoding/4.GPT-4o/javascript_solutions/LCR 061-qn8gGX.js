function kSmallestPairs(nums1, nums2, k) {
    const minHeap = new MinPriorityQueue({ priority: (a, b) => a[0] + a[1] < b[0] + b[1] });
    const result = [];

    for (let i = 0; i < Math.min(k, nums1.length); i++) {
        minHeap.enqueue([nums1[i], nums2[0], 0]);
    }

    while (k-- > 0 && minHeap.size() > 0) {
        const [num1, num2, index] = minHeap.dequeue().element;
        result.push([num1, num2]);

        if (index + 1 < nums2.length) {
            minHeap.enqueue([num1, nums2[index + 1], index + 1]);
        }
    }

    return result;
}