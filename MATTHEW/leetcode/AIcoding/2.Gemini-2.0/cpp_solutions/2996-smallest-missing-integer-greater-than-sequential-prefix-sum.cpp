#include <vector>
#include <numeric>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int missingInteger(vector<int>& nums) {
        int n = nums.size();
        int prefix_sum = nums[0];
        int len = 1;
        for (int i = 1; i < n; ++i) {
            if (nums[i] == nums[i - 1] + 1) {
                prefix_sum += nums[i];
                len++;
            } else {
                break;
            }
        }

        unordered_set<int> s(nums.begin(), nums.end());
        int ans = prefix_sum;
        while (s.count(ans)) {
            ans++;
        }
        return ans;
    }
};