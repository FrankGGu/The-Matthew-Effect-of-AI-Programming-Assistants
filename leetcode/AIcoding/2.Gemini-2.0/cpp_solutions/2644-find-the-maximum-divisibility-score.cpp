#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDivScore(vector<int>& nums, vector<int>& divisors) {
        int max_score = -1;
        int result = -1;

        for (int divisor : divisors) {
            int score = 0;
            for (int num : nums) {
                if (num % divisor == 0) {
                    score++;
                }
            }

            if (score > max_score) {
                max_score = score;
                result = divisor;
            } else if (score == max_score) {
                result = min(result, divisor);
            }
        }

        return result;
    }
};