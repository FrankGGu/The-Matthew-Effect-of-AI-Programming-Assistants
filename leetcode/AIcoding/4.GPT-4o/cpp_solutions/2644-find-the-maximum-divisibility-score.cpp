#include <vector>
#include <algorithm>

class Solution {
public:
    int maxDivScore(std::vector<int>& nums, std::vector<int>& divs) {
        int maxScore = 0, maxDivisor = 0;

        for (int d : divs) {
            int score = 0;
            for (int n : nums) {
                if (n % d == 0) {
                    score++;
                }
            }
            if (score > maxScore || (score == maxScore && d < maxDivisor)) {
                maxScore = score;
                maxDivisor = d;
            }
        }

        return maxDivisor;
    }
};