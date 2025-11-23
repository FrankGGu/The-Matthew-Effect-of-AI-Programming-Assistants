#include <vector>
#include <algorithm>

class Solution {
public:
    int maxNumOfMarkedIndices(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        int i = 0;
        int j = n / 2;
        int count = 0;
        while (i < n / 2 && j < n) {
            if (2LL * nums[i] <= nums[j]) {
                count++;
                i++;
                j++;
            } else {
                j++;
            }
        }
        return count * 2;
    }
};