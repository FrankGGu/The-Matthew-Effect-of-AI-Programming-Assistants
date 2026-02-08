#include <vector>
#include <numeric>

class Solution {
public:
    long long countSubarrays(std::vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::vector<int> p(n, 0);
        for (int i = 1; i < n; ++i) {
            p[i] = p[i - 1] + (nums[i] < nums[i - 1] ? 1 : 0);
        }

        long long count = 0;
        int left = 0;
        for (int right = 0; right < n; ++right) {
            while (p[right] - p[left] > k) {
                left++;
            }
            count += (right - left + 1);
        }

        return count;
    }
};