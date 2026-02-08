#include <vector>

class Solution {
public:
    std::vector<int> rearrangeArray(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> pos;
        std::vector<int> neg;
        for (int i = 0; i < n; ++i) {
            if (nums[i] > 0) {
                pos.push_back(nums[i]);
            } else {
                neg.push_back(nums[i]);
            }
        }
        std::vector<int> res(n);
        int p = 0, ne = 0;
        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                res[i] = pos[p++];
            } else {
                res[i] = neg[ne++];
            }
        }
        return res;
    }
};