#include <vector>
#include <set>
#include <climits>

using namespace std;

class Solution {
public:
    int minAbsoluteDifference(vector<int>& nums, int x) {
        set<int> s;
        int n = nums.size();
        int res = INT_MAX;
        for (int i = x; i < n; ++i) {
            s.insert(nums[i - x]);
            auto it = s.lower_bound(nums[i]);
            if (it != s.end()) {
                res = min(res, abs(nums[i] - *it));
            }
            if (it != s.begin()) {
                --it;
                res = min(res, abs(nums[i] - *it));
            }
        }
        return res;
    }
};