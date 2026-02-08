#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> findMissingAndRepeatedValues(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        int size = n * n;
        std::vector<int> counts(size + 1, 0);

        for (const auto& row : grid) {
            for (int val : row) {
                counts[val]++;
            }
        }

        int repeated = -1;
        int missing = -1;

        for (int i = 1; i <= size; ++i) {
            if (counts[i] == 2) {
                repeated = i;
            }
            if (counts[i] == 0) {
                missing = i;
            }
        }

        return {repeated, missing};
    }
};