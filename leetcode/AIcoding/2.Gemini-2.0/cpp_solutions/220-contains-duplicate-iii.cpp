#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {
        set<long long> window;
        for (int i = 0; i < nums.size(); ++i) {
            long long num = nums[i];
            auto it = window.lower_bound(num - t);
            if (it != window.end() && *it <= num + t) {
                return true;
            }
            window.insert(num);
            if (window.size() > k) {
                window.erase(nums[i - k]);
            }
        }
        return false;
    }
};