#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long makeArrayIdentical(vector<int>& nums, vector<int>& target) {
        sort(nums.begin(), nums.end());
        sort(target.begin(), target.end());

        int n = nums.size();
        long long res = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] < target[i]) {
                res += target[i] - nums[i];
            } else if (nums[i] > target[i]) {
                return -1;
            }
        }

        return res;
    }
};