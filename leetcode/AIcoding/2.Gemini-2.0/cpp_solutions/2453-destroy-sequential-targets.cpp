#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int destroyTargets(vector<int>& nums, int space) {
        unordered_map<int, int> count;
        unordered_map<int, int> first;
        int minVal = INT_MAX;

        for (int i = 0; i < nums.size(); ++i) {
            int rem = nums[i] % space;
            count[rem]++;
            if (first.find(rem) == first.end()) {
                first[rem] = nums[i];
            }
        }

        int maxCount = 0;
        for (auto const& [key, val] : count) {
            maxCount = max(maxCount, val);
        }

        for (auto const& [key, val] : count) {
            if (val == maxCount) {
                minVal = min(minVal, first[key]);
            }
        }

        return minVal;
    }
};