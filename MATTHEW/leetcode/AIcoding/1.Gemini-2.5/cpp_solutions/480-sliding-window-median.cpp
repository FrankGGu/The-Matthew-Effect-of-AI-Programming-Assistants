#include <vector>
#include <set>
#include <iterator>

class Solution {
public:
    std::vector<double> medianSlidingWindow(std::vector<int>& nums, int k) {
        std::vector<double> medians;
        std::multiset<int> window(nums.begin(), nums.begin() + k);

        auto mid = std::next(window.begin(), k / 2);

        for (int i = k; ; ++i) {
            medians.push_back(((double)*mid + *std::prev(mid, 1 - k % 2)) / 2.0);

            if (i == nums.size()) {
                break;
            }

            window.insert(nums[i]);
            if (nums[i] < *mid) {
                mid--;
            }

            if (nums[i - k] <= *mid) {
                mid++;
            }
            window.erase(window.lower_bound(nums[i - k]));
        }

        return medians;
    }
};