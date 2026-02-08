#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumOfFlooredPairs(vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;
        int MOD = 1e9 + 7;

        sort(nums.begin(), nums.end());

        for (int i = 0; i < n; ++i) {
            long long count = 0;
            int num = nums[i];
            int l = 0;
            int r = 0;
            while(true) {
                l = upper_bound(nums.begin(), nums.end(), num * r) - nums.begin();
                r++;
                int upper_bound_val = num * r;

                int next_l = upper_bound(nums.begin(), nums.end(), upper_bound_val - 1) - nums.begin();

                if (next_l <= l) break;

                count = (count + (long long)(next_l - l) * (r - 1)) % MOD;

                if (next_l >= n) break;

            }
            ans = (ans + count) % MOD;
        }

        return (int)ans;
    }
};