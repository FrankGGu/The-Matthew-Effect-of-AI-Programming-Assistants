#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumMountainRemovals(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<int> lis(n, 1); // Longest Increasing Subsequence ending at i
        std::vector<int> lds(n, 1); // Longest Decreasing Subsequence starting at i

        // Calculate LIS for each element from left to right
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    lis[i] = std::max(lis[i], lis[j] + 1);
                }
            }
        }

        // Calculate LDS for each element from right to left
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j > i; --j) {
                if (nums[i] > nums[j]) {
                    lds[i] = std::max(lds[i], lds[j] + 1);
                }
            }
        }

        int max_mountain_len = 0;

        // Find the maximum length of a mountain array
        // A mountain array must have a peak 'i' such that lis[i] > 1 and lds[i] > 1.
        // This ensures there's at least one element strictly increasing before the peak
        // and at least one element strictly decreasing after the peak.
        // Thus, the minimum length of such a mountain array is 3.
        for (int i = 0; i < n; ++i) {
            if (lis[i] > 1 && lds[i] > 1) {
                max_mountain_len = std::max(max_mountain_len, lis[i] + lds[i] - 1);
            }
        }

        // The minimum number of removals is total elements minus the longest mountain array length.
        return n - max_mountain_len;
    }
};