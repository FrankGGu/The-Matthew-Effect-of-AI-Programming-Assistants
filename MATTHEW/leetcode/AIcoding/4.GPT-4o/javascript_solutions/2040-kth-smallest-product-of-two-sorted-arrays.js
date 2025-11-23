var kthSmallestProduct = function(nums1, nums2, k) {
    const m = nums1.length, n = nums2.length;
    let left = 0, right = nums1[m - 1] * nums2[n - 1] + 1;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let count = 0, j = n - 1;

        for (let i = 0; i < m; i++) {
            while (j >= 0 && nums1[i] * nums2[j] > mid) {
                j--;
            }
            count += j + 1;
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
};