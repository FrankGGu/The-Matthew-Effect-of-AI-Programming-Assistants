var maxScore = function(nums1, nums2, k) {
    const n = nums1.length;
    const pairs = nums1.map((num, index) => [num, nums2[index]]);
    pairs.sort((a, b) => b[1] - a[1]);

    const minHeap = new MinPriorityQueue();
    let sum = 0;
    let maxScore = 0;

    for (let i = 0; i < n; i++) {
        const [num1, num2] = pairs[i];
        minHeap.enqueue(num1);
        sum += num1;

        if (minHeap.size() > k) {
            sum -= minHeap.dequeue().element;
        }

        if (minHeap.size() === k) {
            maxScore = Math.max(maxScore, sum * num2);
        }
    }

    return maxScore;
};