#include <iostream>
#include <vector>

class Solution {
public:
    int kOr(std::vector<int>& nums, int k) {
        int result = 0;
        for (int i = 0; i < 32; ++i) {
            int count = 0;
            for (int num : nums) {
                if ((num >> i) & 1) {
                    ++count;
                }
            }
            if (count >= k) {
                result |= (1 << i);
            }
        }
        return result;
    }
};