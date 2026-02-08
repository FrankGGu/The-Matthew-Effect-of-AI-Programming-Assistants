#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxPossibleValue(vector<int>& nums) {
        long long ans = 0;
        for (int i = 0; i < nums.size(); i += 2) {
            ans += min(nums[i], nums[i + 1]) / 2 * 4;
        }
        return ans;
    }
};