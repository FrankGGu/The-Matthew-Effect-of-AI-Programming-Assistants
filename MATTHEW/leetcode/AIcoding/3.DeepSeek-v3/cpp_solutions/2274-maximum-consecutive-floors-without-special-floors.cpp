#include <vector>
#include <algorithm>

class Solution {
public:
    int maxConsecutive(int bottom, int top, std::vector<int>& special) {
        std::sort(special.begin(), special.end());
        int max_gap = 0;

        max_gap = std::max(max_gap, special[0] - bottom);
        for (int i = 1; i < special.size(); ++i) {
            max_gap = std::max(max_gap, special[i] - special[i - 1] - 1);
        }
        max_gap = std::max(max_gap, top - special.back());

        return max_gap;
    }
};