#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minAbsoluteDifference(vector<int>& nums, int x) {
        int n = nums.size();
        int minDiff = INT_MAX;
        set<int> s;

        for (int i = x; i < n; ++i) {
            s.insert(nums[i - x]);
            auto it = s.lower_bound(nums[i]);

            if (it != s.end()) {
                minDiff = min(minDiff, abs(nums[i] - *it));
            }

            if (it != s.begin()) {
                it--;
                minDiff = min(minDiff, abs(nums[i] - *it));
            }
        }

        return minDiff;
    }
};