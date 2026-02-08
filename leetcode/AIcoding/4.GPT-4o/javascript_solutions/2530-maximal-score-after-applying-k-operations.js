var maxScore = function(nums1, nums2, k) {
    const n = nums1.length;
    const pairs = nums1.map((num, i) => [num, nums2[i]]);
    pairs.sort((a, b) => b[1] - a[1]);

    let maxScore = 0;
    let sum = 0;
    const minHeap = new MinPriorityQueue();

    for (let i = 0; i < k; i++) {
        sum += pairs[i][0];
        minHeap.enqueue(pairs[i][0]);
    }

    maxScore = sum * pairs[k - 1][1];

    for (let i = k; i < n; i++) {
        sum += pairs[i][0];
        minHeap.enqueue(pairs[i][0]);
        sum -= minHeap.dequeue().element;

        maxScore = Math.max(maxScore, sum * pairs[i][1]);
    }

    return maxScore;
};