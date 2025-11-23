#include <vector>
#include <algorithm>

class Solution {
public:
    void wiggleSort(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> sorted_nums = nums;
        std::sort(sorted_nums.begin(), sorted_nums.end());

        int k = n - 1;
        for (int i = 1; i < n; i += 2) {
            nums[i] = sorted_nums[k--];
        }
        for (int i = 0; i < n; i += 2) {
            nums[i] = sorted_nums[k--];
        }
    }
};