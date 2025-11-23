class Solution {
public:
    long long minOperations(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        int n = nums1.size();

        if (k == 0) {
            for (int i = 0; i < n; ++i) {
                if (nums1[i] != nums2[i]) {
                    return -1;
                }
            }
            return 0;
        }

        long long total_diff_sum = 0;
        long long positive_diff_sum = 0;

        for (int i = 0; i < n; ++i) {
            long long diff = (long long)nums1[i] - nums2[i];

            if (diff % k != 0) {
                return -1;
            }

            total_diff_sum += diff;
            if (diff > 0) {
                positive_diff_sum += diff;
            }
        }

        if (total_diff_sum != 0) {
            return -1;
        }

        return positive_diff_sum / k;
    }
};