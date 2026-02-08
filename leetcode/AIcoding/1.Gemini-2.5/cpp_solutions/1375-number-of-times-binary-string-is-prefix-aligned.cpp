#include <vector>
#include <algorithm>

class Solution {
public:
    int numTimesAllBlue(std::vector<int>& flips) {
        int count = 0;
        int max_val = 0;
        for (int i = 0; i < flips.size(); ++i) {
            max_val = std::max(max_val, flips[i]);
            if (max_val == i + 1) {
                count++;
            }
        }
        return count;
    }
};