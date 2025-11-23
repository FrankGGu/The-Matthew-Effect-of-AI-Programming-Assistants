#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    long long maxFactorScore(vector<int>& nums) {
        long long maxScore = 0;
        for (int num : nums) {
            long long score = 1;
            for (int i = 2; i <= sqrt(num); ++i) {
                if (num % i == 0) {
                    score *= i;
                    if (i != num / i) {
                        score *= num / i;
                    }
                }
            }
            maxScore = max(maxScore, score);
        }
        return maxScore;
    }
};