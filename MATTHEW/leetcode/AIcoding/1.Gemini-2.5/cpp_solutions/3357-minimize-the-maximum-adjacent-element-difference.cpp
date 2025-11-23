#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int minimizeMax(std::vector<int>& nums, int p) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0, right = nums.back() - nums.front();

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (can_form_pairs(nums, p, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

private:
    bool can_form_pairs(const std::vector<int>& nums, int p, int max_diff) {
        int count = 0;
        for (int i = 0; i < nums.size() - 1;) {
            if (nums[i + 1] - nums[i] <= max_diff) {
                count++;
                i += 2;
            } else {
                i++;
            }
            if (count >= p) {
                return true;
            }
        }
        return false;
    }
};