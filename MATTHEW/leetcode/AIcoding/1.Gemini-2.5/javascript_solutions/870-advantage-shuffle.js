var advantageShuffle = function(nums1, nums2) {
    const n = nums1.length;

    nums1.sort((a, b) => a - b);

    const sortedNums2 = nums2.map((val, idx) => [val, idx]);
    sortedNums2.sort((a, b) => a[0] - b[0]);

    const ans = new Array(n);

    let nums1_ptr = 0; 
    let sortedNums2_low_ptr = 0; 
    let sortedNums2_high_ptr = n - 1; 

    while (nums1_ptr < n) {
        const currentNum1 = nums1[nums1_ptr];
        const currentNum2_val = sortedNums2[sortedNums2_low_ptr][0];
        const currentNum2_idx = sortedNums2[sortedNums2_low_ptr][1];

        if (currentNum1 > currentNum2_val) {
            ans[currentNum2_idx] = currentNum1;
            nums1_ptr++;
            sortedNums2_low_ptr++;
        } else {
            const largestRemainingNum2_idx = sortedNums2[sortedNums2_high_ptr][1];
            ans[largestRemainingNum2_idx] = currentNum1;
            nums1_ptr++;
            sortedNums2_high_ptr--;
        }
    }

    return ans;
};