function kSmallestPairs(nums1, nums2, k) {
    const result = [];
    const heap = [];

    for (let i = 0; i < Math.min(k, nums1.length); i++) {
        heap.push([nums1[i] + nums2[0], i, 0]);
    }

    while (result.length < k && heap.length > 0) {
        const [sum, i, j] = heap.shift();
        result.push([nums1[i], nums2[j]]);

        if (j + 1 < nums2.length) {
            heap.push([nums1[i] + nums2[j + 1], i, j + 1]);
        }
    }

    return result;
}