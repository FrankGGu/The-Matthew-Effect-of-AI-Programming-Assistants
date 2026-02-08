class Solution {
public:
    long long minSumSquareDiff(vector<int>& nums1, vector<int>& nums2, int k) {
        int n = nums1.size();
        vector<long long> diffs(n);
        for (int i = 0; i < n; ++i) {
            diffs[i] = abs(nums1[i] - nums2[i]);
        }

        long long left = 0, right = *max_element(diffs.begin(), diffs.end());
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long required = 0;
            for (long long d : diffs) {
                required += max(0LL, d - mid);
            }

            if (required <= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        long long result = 0;
        for (long long d : diffs) {
            long long reduced = max(0LL, d - left);
            result += reduced * reduced;
        }
        return result;
    }
};