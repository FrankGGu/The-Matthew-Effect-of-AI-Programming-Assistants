#include <vector>

using namespace std;

class Solution {
public:
    long long maxFactorScore(vector<int>& nums) {
        long long maxScore = 0;
        for (int num : nums) {
            long long score = 1;
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    score = i;
                    while (num % i == 0) {
                        num /= i;
                    }
                }
            }
            if (num > 1) {
                score = max(score, (long long)num);
            }
            maxScore += score;
        }
        return maxScore;
    }
};