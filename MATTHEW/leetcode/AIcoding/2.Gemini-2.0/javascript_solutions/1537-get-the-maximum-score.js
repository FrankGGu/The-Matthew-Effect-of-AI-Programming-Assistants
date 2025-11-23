var maxSum = function(nums1, nums2) {
    const MOD = 10**9 + 7;
    let n1 = nums1.length, n2 = nums2.length;
    let i = 0, j = 0;
    let sum1 = 0, sum2 = 0;
    let res = 0;

    while (i < n1 || j < n2) {
        if (i < n1 && (j === n2 || nums1[i] < nums2[j])) {
            sum1 += nums1[i];
            i++;
        } else if (j < n2 && (i === n1 || nums2[j] < nums1[i])) {
            sum2 += nums2[j];
            j++;
        } else {
            res += Math.max(sum1, sum2);
            res %= MOD;
            sum1 = 0;
            sum2 = 0;
            sum1 += nums1[i];
            sum2 += nums2[j];
            i++;
            j++;
        }
    }

    res += Math.max(sum1, sum2);
    res %= MOD;
    return res;
};