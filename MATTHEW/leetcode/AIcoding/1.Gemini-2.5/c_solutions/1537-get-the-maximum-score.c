long long maxSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long sum1 = 0;
    long long sum2 = 0;
    int i = 0;
    int j = 0;
    long long MOD = 1000000007;

    while (i < nums1Size && j < nums2Size) {
        if (nums1[i] < nums2[j]) {
            sum1 = (sum1 + nums1[i]) % MOD;
            i++;
        } else if (nums1[i] > nums2[j]) {
            sum2 = (sum2 + nums2[j]) % MOD;
            j++;
        } else {
            long long current_max_sum = (sum1 > sum2 ? sum1 : sum2);
            sum1 = (current_max_sum + nums1[i]) % MOD;
            sum2 = (current_max_sum + nums1[i]) % MOD;
            i++;
            j++;
        }
    }

    while (i < nums1Size) {
        sum1 = (sum1 + nums1[i]) % MOD;
        i++;
    }

    while (j < nums2Size) {
        sum2 = (sum2 + nums2[j]) % MOD;
        j++;
    }

    return (sum1 > sum2 ? sum1 : sum2);
}