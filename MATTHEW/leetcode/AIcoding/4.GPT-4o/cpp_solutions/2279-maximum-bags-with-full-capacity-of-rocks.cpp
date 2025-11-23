#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumBags(std::vector<int>& capacity, std::vector<int>& rocks, int additionalRocks) {
        int n = capacity.size();
        std::vector<int> space(n);

        for (int i = 0; i < n; ++i) {
            space[i] = capacity[i] - rocks[i];
        }

        std::sort(space.begin(), space.end());

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (additionalRocks >= space[i]) {
                additionalRocks -= space[i];
                count++;
            } else {
                break;
            }
        }

        return count;
    }
};