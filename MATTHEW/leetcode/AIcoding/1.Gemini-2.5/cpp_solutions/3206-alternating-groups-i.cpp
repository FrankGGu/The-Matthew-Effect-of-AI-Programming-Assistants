#include <vector>
#include <numeric>

class Solution {
public:
    int numberOfAlternatingGroups(std::vector<int>& colors) {
        int n = colors.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            int c1 = colors[i];
            int c2 = colors[(i + 1) % n];
            int c3 = colors[(i + 2) % n];
            if (c1 != c2 && c2 != c3) {
                count++;
            }
        }
        return count;
    }
};