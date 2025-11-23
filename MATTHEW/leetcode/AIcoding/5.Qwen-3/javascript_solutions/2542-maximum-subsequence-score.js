function maxScore(nums1, nums2, k) {
    const pairs = nums1.map((num, i) => [num, nums2[i]]);
    pairs.sort((a, b) => b[1] - a[1]);

    const minHeap = [];
    let sum = 0;
    let maxScore = 0;

    for (let i = 0; i < k; i++) {
        sum += pairs[i][0];
        minHeap.push(pairs[i][0]);
        minHeap.sort((a, b) => a - b);
    }

    maxScore = sum * pairs[k - 1][1];

    for (let i = k; i < pairs.length; i++) {
        const removed = minHeap.shift();
        sum -= removed;
        sum += pairs[i][0];
        minHeap.push(pairs[i][0]);
        minHeap.sort((a, b) => a - b);
        maxScore = Math.max(maxScore, sum * pairs[i][1]);
    }

    return maxScore;
}