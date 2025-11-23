var advantageCount = function(nums1, nums2) {
    const n = nums1.length;
    const idxB = Array.from({length: n}, (_, i) => i);
    idxB.sort((a, b) => nums2[a] - nums2[b]);
    nums1.sort((a, b) => a - b);

    const res = new Array(n);
    let left = 0, right = n - 1;

    for (let i = n - 1; i >= 0; i--) {
        const idx = idxB[i];
        if (nums1[right] > nums2[idx]) {
            res[idx] = nums1[right];
            right--;
        } else {
            res[idx] = nums1[left];
            left++;
        }
    }

    return res;
};