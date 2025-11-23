var kSmallestPairs = function(nums1, nums2, k) {
    const pq = [];
    for (let i = 0; i < Math.min(nums1.length, k); i++) {
        for (let j = 0; j < Math.min(nums2.length, k); j++) {
            pq.push([nums1[i], nums2[j], nums1[i] + nums2[j]]);
        }
    }

    pq.sort((a, b) => a[2] - b[2]);

    const result = [];
    for (let i = 0; i < Math.min(k, pq.length); i++) {
        result.push([pq[i][0], pq[i][1]]);
    }

    return result;
};