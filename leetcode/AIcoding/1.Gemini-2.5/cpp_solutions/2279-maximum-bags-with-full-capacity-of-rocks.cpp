#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maximumBags(std::vector<int>& capacity, std::vector<int>& rocks, int additionalRocks) {
        int n = capacity.size();
        std::vector<int> remainingCapacity(n);
        for (int i = 0; i < n; ++i) {
            remainingCapacity[i] = capacity[i] - rocks[i];
        }

        std::sort(remainingCapacity.begin(), remainingCapacity.end());

        int fullBags = 0;
        for (int i = 0; i < n; ++i) {
            if (remainingCapacity[i] <= additionalRocks) {
                additionalRocks -= remainingCapacity[i];
                fullBags++;
            } else {
                break;
            }
        }

        return fullBags;
    }
};