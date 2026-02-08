#include <vector>
#include <set>
#include <cmath>

class Solution {
public:
    bool containsNearbyAlmostDuplicate(std::vector<int>& nums, int k, int t) {
        std::set<long long> window;

        for (int i = 0; i < nums.size(); ++i) {
            if (i > k) {
                window.erase(nums[i - k - 1]);
            }

            long long lower_bound_val = (long long)nums[i] - t;
            long long upper_bound_val = (long long)nums[i] + t;

            auto it = window.lower_bound(lower_bound_val);

            if (it != window.end() && *it <= upper_bound_val) {
                return true;
            }

            window.insert(nums[i]);
        }

        return false;
    }
};