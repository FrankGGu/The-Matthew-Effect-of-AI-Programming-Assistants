var minSumSquareDiff = function(nums1, nums2, k1, k2) {
    const n = nums1.length;
    const k = k1 + k2;

    const MAX_DIFF = 100000;
    const freq = new Array(MAX_DIFF + 1).fill(0);
    let maxDiff = 0;

    for (let i = 0; i < n; i++) {
        const diff = Math.abs(nums1[i] - nums2[i]);
        freq[diff]++;
        if (diff > maxDiff) {
            maxDiff = diff;
        }
    }

    let remainingK = k;
    for (let d = maxDiff; d > 0 && remainingK > 0; d--) {
        if (freq[d] > 0) {
            const numToReduce = Math.min(freq[d], remainingK);
            freq[d] -= numToReduce;
            freq[d - 1] += numToReduce;
            remainingK -= numToReduce;
        }
    }

    let sumOfSquares = 0;
    for (let d = 0; d <= maxDiff; d++) {
        if (freq[d] > 0) {
            sumOfSquares += freq[d] * d * d;
        }
    }

    return sumOfSquares;
};