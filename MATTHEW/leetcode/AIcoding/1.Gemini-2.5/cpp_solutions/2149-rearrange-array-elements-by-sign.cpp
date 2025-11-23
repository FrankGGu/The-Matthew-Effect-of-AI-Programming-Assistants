#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> rearrangeArray(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> ans(n);
        int pos_idx = 0;
        int neg_idx = 1;

        for (int num : nums) {
            if (num > 0) {
                ans[pos_idx] = num;
                pos_idx += 2;
            } else {
                ans[neg_idx] = num;
                neg_idx += 2;
            }
        }
        return ans;
    }
};