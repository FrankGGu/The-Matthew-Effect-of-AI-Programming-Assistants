#include <vector>
#include <algorithm>

class Solution {
public:
    int minCostToMoveChips(std::vector<int>& position) {
        int even_count = 0;
        int odd_count = 0;
        for (int pos : position) {
            if (pos % 2 == 0) {
                even_count++;
            } else {
                odd_count++;
            }
        }
        return std::min(even_count, odd_count);
    }
};