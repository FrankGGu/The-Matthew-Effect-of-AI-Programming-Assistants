var longestNondecreasingSubarray = function(nums1, nums2) {
    const n = nums1.length;
    if (n === 0) {
        return 0;
    }

    let prev0 = 1; // Length of longest non-decreasing subarray ending at i-1, using nums1[i-1]
    let prev1 = 1; // Length of longest non-decreasing subarray ending at i-1, using nums2[i-1]
    let maxLen = 1;

    for (let i = 1; i < n; i++) {
        let curr0 = 1; // Length of longest non-decreasing subarray ending at i, using nums1[i]
        let curr1 = 1; // Length of longest non-decreasing subarray ending at i, using nums2[i]

        // Calculate curr0 (ending with nums1[i])
        if (nums1[i] >= nums1[i-1]) {
            curr0 = Math.max(curr0, prev0 + 1);
        }
        if (nums1[i] >= nums2[i-1]) {
            curr0 = Math.max(curr0, prev1 + 1);
        }

        // Calculate curr1 (ending with nums2[i])
        if (nums2[i] >= nums1[i-1]) {
            curr1 = Math.max(curr1, prev0 + 1);
        }
        if (nums2[i] >= nums2[i-1]) {
            curr1 = Math.max(curr1, prev1 + 1);
        }

        maxLen = Math.max(maxLen, curr0, curr1);

        prev0 = curr0;
        prev1 = curr1;
    }

    return maxLen;
};