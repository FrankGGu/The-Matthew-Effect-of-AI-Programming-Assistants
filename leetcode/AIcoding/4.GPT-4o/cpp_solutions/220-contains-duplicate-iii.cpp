#include <vector>
#include <set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int indexDiff, int valueDiff) {
        if (indexDiff <= 0 || valueDiff < 0) return false;
        set<long> window;
        for (int i = 0; i < nums.size(); i++) {
            if (i > indexDiff) {
                window.erase(nums[i - indexDiff - 1]);
            }
            auto pos = window.lower_bound(static_cast<long>(nums[i]) - valueDiff);
            if (pos != window.end() && *pos <= static_cast<long>(nums[i]) + valueDiff) {
                return true;
            }
            window.insert(nums[i]);
        }
        return false;
    }
};