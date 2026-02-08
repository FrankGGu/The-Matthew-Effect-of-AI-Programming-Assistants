#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> rearrangeArray(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        std::vector<int> ans(n);
        int left = 0;
        int right = n - 1;
        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                ans[i] = nums[left++];
            } else {
                ans[i] = nums[right--];
            }
        }
        return ans;
    }
};