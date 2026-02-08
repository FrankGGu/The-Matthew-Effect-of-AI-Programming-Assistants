var maxSum = function(nums1, nums2) {
    const MOD = 1e9 + 7;
    let i = 0, j = 0;
    let sum1 = 0, sum2 = 0;
    let res = 0;
    const m = nums1.length, n = nums2.length;

    while (i < m && j < n) {
        if (nums1[i] < nums2[j]) {
            sum1 += nums1[i];
            i++;
        } else if (nums1[i] > nums2[j]) {
            sum2 += nums2[j];
            j++;
        } else {
            res += Math.max(sum1, sum2) + nums1[i];
            sum1 = 0;
            sum2 = 0;
            i++;
            j++;
        }
    }

    while (i < m) {
        sum1 += nums1[i];
        i++;
    }

    while (j < n) {
        sum2 += nums2[j];
        j++;
    }

    res += Math.max(sum1, sum2);
    return res % MOD;
};