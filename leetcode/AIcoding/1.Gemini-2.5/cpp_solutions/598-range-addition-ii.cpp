#include <vector>
#include <algorithm>

class Solution {
public:
    int maxCount(int m, int n, std::vector<std::vector<int>>& ops) {
        int min_r = m;
        int min_c = n;

        for (const auto& op : ops) {
            min_r = std::min(min_r, op[0]);
            min_c = std::min(min_c, op[1]);
        }

        return min_r * min_c;
    }
};