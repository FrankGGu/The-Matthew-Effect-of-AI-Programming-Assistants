#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int maximizeTheMinimumGameScore(std::vector<int>& gridA, std::vector<int>& gridB) {
        int n = gridA.size();

        std::sort(gridA.begin(), gridA.end());
        std::sort(gridB.begin(), gridB.end());

        int score1 = INT_MAX;
        for (int i = 0; i < n; ++i) {
            score1 = std::min(score1, std::min(gridA[i], gridB[n - 1 - i]));
        }

        int score2 = INT_MAX;
        for (int i = 0; i < n; ++i) {
            score2 = std::min(score2, std::min(gridA[i], gridB[i]));
        }

        return std::max(score1, score2);
    }
};