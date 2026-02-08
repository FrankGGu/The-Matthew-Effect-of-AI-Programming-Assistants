#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> movementOfRobots(int n, std::vector<int>& basePositions, std::vector<int>& diffs) {
        std::vector<int> finalPositions(n);
        for (int i = 0; i < n; ++i) {
            finalPositions[i] = basePositions[i] + diffs[i];
        }
        return finalPositions;
    }
};