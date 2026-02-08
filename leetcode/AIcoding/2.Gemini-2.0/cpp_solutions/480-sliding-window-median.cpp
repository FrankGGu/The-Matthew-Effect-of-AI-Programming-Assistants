#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<double> medianSlidingWindow(vector<int>& nums, int k) {
        vector<double> result;
        multiset<int> window(nums.begin(), nums.begin() + k);

        for (int i = k; i <= nums.size(); ++i) {
            auto mid = next(window.begin(), k / 2);
            if (k % 2 == 0) {
                result.push_back((*mid + *prev(mid)) / 2.0);
            } else {
                result.push_back(*mid);
            }

            if (i == nums.size()) break;

            window.insert(nums[i]);
            window.erase(window.find(nums[i - k]));
        }

        return result;
    }
};