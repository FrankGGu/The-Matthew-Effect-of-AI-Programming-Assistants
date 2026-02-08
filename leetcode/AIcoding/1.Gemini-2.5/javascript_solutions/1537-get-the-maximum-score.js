var maxSum = function(nums1, nums2) {
    let i = 0;
    let j = 0;
    const n1 = nums1.length;
    const n2 = nums2.length;

    let sum1 = 0;
    let sum2 = 0;
    let max_score = 0;

    const MOD = 10**9 + 7;

    while (i < n1 && j < n2) {
        if (nums1[i] < nums2[j]) {
            sum1 += nums1[i];
            i++;
        } else if (nums2[j] < nums1[i]) {
            sum2 += nums2[j];
            j++;
        } else {
            max_score = (max_score + Math.max(sum1, sum2) + nums1[i]) % MOD;
            sum1 = 0;
            sum2 = 0;
            i++;
            j++;
        }
    }

    while (i < n1) {
        sum1 += nums1[i];
        i++;
    }

    while (j < n2) {
        sum2 += nums2[j];
        j++;
    }

    max_score = (max_score + Math.max(sum1, sum2)) % MOD;

    return max_score;
};