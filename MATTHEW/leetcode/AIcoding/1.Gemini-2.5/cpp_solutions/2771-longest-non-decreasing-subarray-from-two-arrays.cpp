#include <vector>
#include <algorithm>

class Solution {
public:
    int longestNondecreasingSubarray(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        if (n == 0) {
            return 0;
        }

        int ans = 1;
        int dp0 = 1; // Length of longest non-decreasing subarray ending at previous index, using nums1[i-1]
        int dp1 = 1; // Length of longest non-decreasing subarray ending at previous index, using nums2[i-1]

        for (int i = 1; i < n; ++i) {
            int current_dp0 = 1; // Length of longest non-decreasing subarray ending at current index, using nums1[i]
            int current_dp1 = 1; // Length of longest non-decreasing subarray ending at current index, using nums2[i]

            // Calculate current_dp0 (using nums1[i])
            if (nums1[i] >= nums1[i-1]) {
                current_dp0 = std::max(current_dp0, dp0 + 1);
            }
            if (nums1[i] >= nums2[i-1]) {
                current_dp0 = std::max(current_dp0, dp1 + 1);
            }

            // Calculate current_dp1 (using nums2[i])
            if (nums2[i] >= nums1[i-1]) {
                current_dp1 = std::max(current_dp1, dp0 + 1);
            }
            if (nums2[i] >= nums2[i-1]) {
                current_dp1 = std::max(current_dp1, dp1 + 1);
            }

            dp0 = current_dp0;
            dp1 = current_dp1;
            ans = std::max({ans, dp0, dp1});
        }

        return ans;
    }
};