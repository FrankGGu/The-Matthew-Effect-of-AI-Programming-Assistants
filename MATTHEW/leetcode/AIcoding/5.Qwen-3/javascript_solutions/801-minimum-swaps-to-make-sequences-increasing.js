function minSwap(nums1, nums2) {
    let n = nums1.length;
    let swap = new Array(n).fill(0);
    let noSwap = new Array(n).fill(0);

    swap[0] = 1;
    noSwap[0] = 0;

    for (let i = 1; i < n; i++) {
        if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
            swap[i] = swap[i - 1] + 1;
            noSwap[i] = noSwap[i - 1];
        } else if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
            swap[i] = Math.min(swap[i - 1], noSwap[i - 1]) + 1;
            noSwap[i] = Math.min(swap[i - 1], noSwap[i - 1]);
        } else {
            if (nums1[i] > nums1[i - 1]) {
                swap[i] = swap[i - 1] + 1;
                noSwap[i] = noSwap[i - 1];
            } else {
                swap[i] = noSwap[i - 1] + 1;
                noSwap[i] = swap[i - 1];
            }
        }
    }

    return Math.min(swap[n - 1], noSwap[n - 1]);
}