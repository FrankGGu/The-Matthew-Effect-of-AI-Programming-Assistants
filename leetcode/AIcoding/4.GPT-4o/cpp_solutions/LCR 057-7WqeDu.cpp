#include <vector>
#include <set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {
        if (k <= 0 || t < 0) return false;
        set<long> window;
        for (int i = 0; i < nums.size(); i++) {
            if (i > k) {
                window.erase(nums[i - k - 1]);
            }
            auto pos = window.lower_bound((long)nums[i] - t);
            if (pos != window.end() && *pos <= (long)nums[i] + t) {
                return true;
            }
            window.insert(nums[i]);
        }
        return false;
    }
};