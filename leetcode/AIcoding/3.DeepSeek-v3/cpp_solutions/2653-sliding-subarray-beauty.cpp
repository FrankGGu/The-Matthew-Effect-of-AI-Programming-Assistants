#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> getSubarrayBeauty(vector<int>& nums, int k, int x) {
        vector<int> result;
        multiset<int> window(nums.begin(), nums.begin() + k);
        auto it = next(window.begin(), x - 1);
        result.push_back(min(*it, 0));

        for (int i = k; i < nums.size(); ++i) {
            window.insert(nums[i]);
            if (nums[i] < *it) {
                --it;
            }

            if (nums[i - k] <= *it) {
                ++it;
            }
            window.erase(window.lower_bound(nums[i - k]));

            result.push_back(min(*it, 0));
        }

        return result;
    }
};