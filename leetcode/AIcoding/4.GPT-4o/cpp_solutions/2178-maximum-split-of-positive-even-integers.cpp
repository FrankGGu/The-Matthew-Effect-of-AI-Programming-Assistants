#include <vector>

class Solution {
public:
    std::vector<int> maximumEvenSplit(int finalSum) {
        if (finalSum % 2 != 0) return {};
        std::vector<int> result;
        for (int i = finalSum; i > 0; i -= 2) {
            result.push_back(i);
        }
        return result;
    }
};