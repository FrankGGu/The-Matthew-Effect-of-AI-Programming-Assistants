#include <vector>

class Solution {
public:
    int minimumLevels(std::vector<int>& possible) {
        int n = possible.size();

        int totalScore = 0;
        for (int i = 0; i < n; ++i) {
            if (possible[i] == 1) {
                totalScore += 1;
            } else {
                totalScore += -1;
            }
        }

        int currentPrefixScore = 0;
        for (int i = 0; i < n; ++i) {
            if (possible[i] == 1) {
                currentPrefixScore += 1;
            } else {
                currentPrefixScore += -1;
            }

            int remainingScore = totalScore - currentPrefixScore;

            if (currentPrefixScore > remainingScore) {
                return i + 1;
            }
        }

        // According to the problem statement, a solution is always guaranteed.
        // So, this line should not be reached.
        return -1; 
    }
};