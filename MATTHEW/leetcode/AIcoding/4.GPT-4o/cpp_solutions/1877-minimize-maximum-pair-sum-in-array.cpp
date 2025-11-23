#include <vector>
#include <algorithm>

class Solution {
public:
    int minimizeArrayValue(std::vector<int>& nums) {
        int n = nums.size();
        std::sort(nums.begin(), nums.end());
        int left = 0, right = nums[n - 1], result = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long sum = 0;
            for (int num : nums) {
                sum += std::min(num, mid);
            }
            if (sum >= (long long)mid * n) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return result;
    }
};