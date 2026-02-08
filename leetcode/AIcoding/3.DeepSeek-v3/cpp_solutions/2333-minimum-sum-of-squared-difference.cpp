class Solution {
public:
    long long minSumSquareDiff(vector<int>& nums1, vector<int>& nums2, int k1, int k2) {
        int n = nums1.size();
        vector<int> diff(n);
        for (int i = 0; i < n; ++i) {
            diff[i] = abs(nums1[i] - nums2[i]);
        }
        int k = k1 + k2;
        long long total = accumulate(diff.begin(), diff.end(), 0LL);
        if (total <= k) return 0;

        int left = 0, right = *max_element(diff.begin(), diff.end());
        while (left < right) {
            int mid = left + (right - left) / 2;
            long long sum = 0;
            for (int d : diff) {
                sum += max(0, d - mid);
            }
            if (sum <= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        long long res = 0;
        for (int d : diff) {
            if (d > left) {
                k -= (d - left);
                d = left;
            }
            res += 1LL * d * d;
        }
        res -= 1LL * left * left * k;
        if (left > 0) {
            res += 1LL * (left - 1) * (left - 1) * k;
        }
        return res;
    }
};