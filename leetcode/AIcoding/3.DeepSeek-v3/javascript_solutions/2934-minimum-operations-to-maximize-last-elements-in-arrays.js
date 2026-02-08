var minOperations = function(nums1, nums2) {
    const n = nums1.length;
    let count1 = 0, count2 = 0;
    let last1 = nums1[n - 1], last2 = nums2[n - 1];

    for (let i = 0; i < n - 1; i++) {
        if (nums1[i] > last1 || nums2[i] > last2) {
            if (nums1[i] <= last2 && nums2[i] <= last1) {
                count1++;
            } else {
                count1 = Infinity;
                break;
            }
        }
    }

    for (let i = 0; i < n - 1; i++) {
        if (nums1[i] > last2 || nums2[i] > last1) {
            if (nums1[i] <= last1 && nums2[i] <= last2) {
                count2++;
            } else {
                count2 = Infinity;
                break;
            }
        }
    }

    const res = Math.min(count1, count2 + 1);
    return res === Infinity ? -1 : res;
};