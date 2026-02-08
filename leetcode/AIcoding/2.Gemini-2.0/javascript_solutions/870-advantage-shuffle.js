var advantageCount = function(nums1, nums2) {
    const n = nums1.length;
    nums1.sort((a, b) => a - b);
    const idx2 = Array.from({ length: n }, (_, i) => i);
    idx2.sort((i, j) => nums2[i] - nums2[j]);
    const ans = new Array(n);
    let left = 0, right = n - 1;
    for (let i = 0; i < n; i++) {
        if (nums1[i] > nums2[idx2[left]]) {
            ans[idx2[left]] = nums1[i];
            left++;
        } else {
            ans[idx2[right]] = nums1[i];
            right--;
        }
    }
    return ans;
};