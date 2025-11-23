#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxDivScore(vector<int>& nums, vector<int>& divisors) {
        int maxScore = -1;
        int result = divisors[0];

        for (int d : divisors) {
            int score = 0;
            for (int n : nums) {
                if (n % d == 0) {
                    score++;
                }
            }
            if (score > maxScore || (score == maxScore && d < result)) {
                maxScore = score;
                result = d;
            }
        }

        return result;
    }
};