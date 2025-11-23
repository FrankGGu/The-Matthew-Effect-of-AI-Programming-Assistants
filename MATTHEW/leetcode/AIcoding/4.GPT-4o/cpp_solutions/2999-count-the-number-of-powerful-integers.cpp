#include <vector>
#include <unordered_set>
#include <cmath>

class Solution {
public:
    std::vector<int> powerfulIntegers(int x, int y, int bound) {
        std::unordered_set<int> result;
        for (int i = 0; pow(x, i) < bound; ++i) {
            for (int j = 0; pow(y, j) < bound; ++j) {
                int value = pow(x, i) + pow(y, j);
                if (value <= bound) {
                    result.insert(value);
                } else {
                    break;
                }
                if (y == 1) break;
            }
            if (x == 1) break;
        }
        return std::vector<int>(result.begin(), result.end());
    }
};