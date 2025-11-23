class Solution {
public:
    int maxNonDecreasingLength(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        if (n == 0) return 0;

        int dp1 = 1, dp2 = 1;
        int res = 1;

        for (int i = 1; i < n; ++i) {
            int new_dp1 = 1, new_dp2 = 1;
            if (nums1[i] >= nums1[i-1]) {
                new_dp1 = max(new_dp1, dp1 + 1);
            }
            if (nums1[i] >= nums2[i-1]) {
                new_dp1 = max(new_dp1, dp2 + 1);
            }
            if (nums2[i] >= nums1[i-1]) {
                new_dp2 = max(new_dp2, dp1 + 1);
            }
            if (nums2[i] >= nums2[i-1]) {
                new_dp2 = max(new_dp2, dp2 + 1);
            }
            dp1 = new_dp1;
            dp2 = new_dp2;
            res = max(res, max(dp1, dp2));
        }

        return res;
    }
};