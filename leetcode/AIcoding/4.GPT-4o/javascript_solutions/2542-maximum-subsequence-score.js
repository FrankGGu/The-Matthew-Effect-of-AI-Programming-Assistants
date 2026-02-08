var maxScore = function(nums1, nums2, k) {
    const n = nums1.length;
    const pairs = nums1.map((num, i) => [num, nums2[i]]);
    pairs.sort((a, b) => b[1] - a[1]);

    let maxScore = 0;
    let currentSum = 0;
    const minHeap = [];

    for (let i = 0; i < k; i++) {
        currentSum += pairs[i][0];
        minHeap.push(pairs[i][0]);
    }
    maxScore = currentSum * pairs[k - 1][1];

    for (let i = k; i < n; i++) {
        currentSum += pairs[i][0];
        minHeap.push(pairs[i][0]);
        currentSum -= Math.min(...minHeap);
        minHeap.splice(minHeap.indexOf(Math.min(...minHeap)), 1);
        maxScore = Math.max(maxScore, currentSum * pairs[i][1]);
    }

    return maxScore;
};