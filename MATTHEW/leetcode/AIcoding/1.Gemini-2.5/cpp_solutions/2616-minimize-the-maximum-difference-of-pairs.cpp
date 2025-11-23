#include <vector>
#include <algorithm>

class Solution {
public:
    int minimizeMax(std::vector<int>& nums, int p) {
        if (p == 0) {
            return 0;
        }

        std::sort(nums.begin(), nums.end());

        int n = nums.size();
        int left = 0;
        int right = nums[n - 1] - nums[0];
        int ans = right;

        auto can_form_p_pairs = [&](int max_diff) {
            int count = 0;
            for (int i = 1; i < n; ++i) {
                if (nums[i] - nums[i - 1] <= max_diff) {
                    count++;
                    i++;
                }
            }
            return count >= p;
        };

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (can_form_p_pairs(mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};