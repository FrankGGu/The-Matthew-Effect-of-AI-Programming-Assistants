#include <vector>
#include <algorithm>

class Solution {
public:
    int findLongestChain(std::vector<std::vector<int>>& pairs) {
        if (pairs.empty()) {
            return 0;
        }

        std::sort(pairs.begin(), pairs.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] < b[1];
        });

        int chainLength = 1;
        int currentEnd = pairs[0][1];

        for (size_t i = 1; i < pairs.size(); ++i) {
            if (pairs[i][0] > currentEnd) {
                chainLength++;
                currentEnd = pairs[i][1];
            }
        }

        return chainLength;
    }
};