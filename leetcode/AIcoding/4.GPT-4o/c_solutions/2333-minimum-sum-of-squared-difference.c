#define MOD 1000000007

long long minSumSquareDiff(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    long long sum = 0;
    long long diff[100001] = {0};
    int n = nums1Size;

    for (int i = 0; i < n; i++) {
        diff[abs(nums1[i] - nums2[i])]++;
    }

    for (int i = 100000; i >= 0 && k > 0; i--) {
        if (diff[i] > 0) {
            long long take = diff[i] < k ? diff[i] : k;
            diff[i] -= take;
            k -= take;
            if (i > 0) {
                diff[i - 1] += take;
            }
        }
    }

    for (int i = 0; i <= 100000; i++) {
        sum = (sum + (long long)i * i * diff[i]) % MOD;
    }

    return sum;
}