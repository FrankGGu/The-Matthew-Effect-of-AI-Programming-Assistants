#include <vector>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        int count = 0;
        for (int num : nums) {
            if (num < k) {
                count++;
            }
        }
        return count;
    }
};