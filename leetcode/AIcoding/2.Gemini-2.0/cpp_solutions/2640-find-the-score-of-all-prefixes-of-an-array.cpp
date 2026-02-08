#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> findPrefixScore(vector<int>& nums) {
        int n = nums.size();
        vector<long long> ans(n);
        int max_val = 0;
        long long current_sum = 0;
        for (int i = 0; i < n; ++i) {
            max_val = max(max_val, nums[i]);
            current_sum += nums[i] + max_val;
            ans[i] = current_sum;
        }
        return ans;
    }
};