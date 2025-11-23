#include <vector>

class Solution {
public:
    int xorBeauty(std::vector<int>& nums) {
        int result = 0;
        for (int num : nums) {
            result ^= num;
        }
        return result;
    }
};