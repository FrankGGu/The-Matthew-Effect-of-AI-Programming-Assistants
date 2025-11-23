#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minimumSize(std::vector<int>& nums, int maxOperations) {
        int left = 1;
        int right = 0;
        for (int num : nums) {
            right = std::max(right, num);
        }

        int ans = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long ops = 0;
            for (int num : nums) {
                ops += (long long)(num - 1) / mid;
            }

            if (ops <= maxOperations) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
};