#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeOR(vector<int>& nums, int k) {
        int n = nums.size();
        int ans = 0;
        for (int bit = 30; bit >= 0; --bit) {
            int current_or = ans | (1 << bit);
            int operations = 0;
            int current_subarray_or = 0;
            for (int i = 0; i < n; ++i) {
                if ((nums[i] | current_or) == current_or) {
                    continue;
                }
                current_subarray_or |= nums[i];
                if ((current_subarray_or | current_or) == current_or) {
                    current_subarray_or = 0;
                } else {
                    operations++;
                    current_subarray_or = 0;
                }
            }
            if (operations <= k) {
                ans = current_or;
            }
        }
        return ans;
    }
};