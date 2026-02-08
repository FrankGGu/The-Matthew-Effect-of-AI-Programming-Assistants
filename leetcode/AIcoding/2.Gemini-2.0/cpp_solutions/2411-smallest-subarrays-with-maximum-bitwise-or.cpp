#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestSubarrays(vector<int>& nums) {
        int n = nums.size();
        vector<int> ans(n);
        vector<int> last(32, -1);

        for (int i = n - 1; i >= 0; --i) {
            for (int j = 0; j < 32; ++j) {
                if ((nums[i] >> j) & 1) {
                    last[j] = i;
                }
            }

            int max_idx = i;
            for (int j = 0; j < 32; ++j) {
                max_idx = max(max_idx, last[j]);
            }

            ans[i] = max_idx == -1 ? 1 : max_idx - i + 1;
        }

        return ans;
    }
};