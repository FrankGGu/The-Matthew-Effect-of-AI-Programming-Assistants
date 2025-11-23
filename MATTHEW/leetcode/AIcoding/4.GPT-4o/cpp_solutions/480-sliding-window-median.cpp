#include <vector>
#include <algorithm>
#include <set>

using namespace std;

class Solution {
public:
    vector<double> medianSlidingWindow(vector<int>& nums, int k) {
        multiset<int> window;
        vector<double> medians;

        for (int i = 0; i < nums.size(); ++i) {
            window.insert(nums[i]);
            if (window.size() > k) {
                window.erase(window.find(nums[i - k]));
            }
            if (window.size() == k) {
                auto it = next(window.begin(), (k - 1) / 2);
                double median = *it;
                if (k % 2 == 0) {
                    median = (median + *prev(it)) / 2.0;
                }
                medians.push_back(median);
            }
        }
        return medians;
    }
};