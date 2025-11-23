class Solution {
public:
    int minAbsoluteSumDiff(vector<int>& nums1, vector<int>& nums2) {
        int mod = 1e9 + 7;
        int n = nums1.size();
        vector<int> sorted(nums1);
        sort(sorted.begin(), sorted.end());

        long sum = 0;
        int max_reduce = 0;

        for (int i = 0; i < n; ++i) {
            int diff = abs(nums1[i] - nums2[i]);
            sum += diff;

            int left = 0, right = n - 1;
            int best = diff;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (sorted[mid] < nums2[i]) {
                    best = min(best, abs(sorted[mid] - nums2[i]));
                    left = mid + 1;
                } else if (sorted[mid] > nums2[i]) {
                    best = min(best, abs(sorted[mid] - nums2[i]));
                    right = mid - 1;
                } else {
                    best = 0;
                    break;
                }
            }

            max_reduce = max(max_reduce, diff - best);
        }

        return (sum - max_reduce) % mod;
    }
};