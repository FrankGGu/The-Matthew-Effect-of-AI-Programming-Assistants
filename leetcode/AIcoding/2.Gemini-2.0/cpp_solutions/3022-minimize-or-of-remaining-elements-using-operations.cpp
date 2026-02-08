#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeOR(vector<int>& nums, int k) {
        int n = nums.size();
        int ans = -1;

        for (int i = 0; i < (1 << n); ++i) {
            if (__builtin_popcount(i) > k) continue;

            vector<int> temp;
            int ops = 0;

            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    ops++;
                }
            }

            if (ops > k) continue;

            for (int j = 0; j < n; ++j) {
                if (!((i >> j) & 1)) {
                    temp.push_back(nums[j]);
                }
            }

            if(ops < k){
                int needed = k - ops;
                while(needed > 0){
                    temp.push_back(0);
                    needed--;
                }
            }

            int current_or = 0;
            for (int val : temp) {
                current_or |= val;
            }

            if (ans == -1 || current_or < ans) {
                ans = current_or;
            }
        }

        return ans;
    }
};