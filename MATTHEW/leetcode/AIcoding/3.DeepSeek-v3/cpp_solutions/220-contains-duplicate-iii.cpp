#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {
        set<long long> window;
        for (int i = 0; i < nums.size(); ++i) {
            if (i > k) {
                window.erase(nums[i - k - 1]);
            }
            auto it = window.lower_bound((long long)nums[i] - t);
            if (it != window.end() && *it <= (long long)nums[i] + t) {
                return true;
            }
            window.insert(nums[i]);
        }
        return false;
    }
};