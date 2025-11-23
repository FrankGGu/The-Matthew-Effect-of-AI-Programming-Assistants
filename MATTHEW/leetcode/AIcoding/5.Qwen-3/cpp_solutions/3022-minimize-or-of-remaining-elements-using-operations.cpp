#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minOrAfterOperations(std::vector<int>& nums) {
        int result = 0;
        for (int bit = 30; bit >= 0; --bit) {
            int count = 0;
            for (int num : nums) {
                if ((num & (1 << bit)) == 0) {
                    ++count;
                }
            }
            if (count > 0) {
                result |= (1 << bit);
            }
        }
        return result;
    }
};