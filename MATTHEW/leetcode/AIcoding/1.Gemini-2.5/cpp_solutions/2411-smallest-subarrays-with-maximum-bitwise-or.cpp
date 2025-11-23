#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> smallestSubarrays(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> ans(n);

        std::vector<int> max_or_suffix(n);
        max_or_suffix[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            max_or_suffix[i] = nums[i] | max_or_suffix[i + 1];
        }

        std::vector<int> last_pos(31, -1);

        for (int i = n - 1; i >= 0; --i) {
            for (int k = 0; k < 31; ++k) {
                if ((nums[i] >> k) & 1) {
                    last_pos[k] = i;
                }
            }

            int required_j = i;
            for (int k = 0; k < 31; ++k) {
                if ((max_or_suffix[i] >> k) & 1) {
                    required_j = std::max(required_j, last_pos[k]);
                }
            }
            ans[i] = required_j - i + 1;
        }

        return ans;
    }
};