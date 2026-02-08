class Solution {
public:
    int maxDivScore(vector<int>& nums, vector<int>& divisors) {
        int maxScore = -1;
        int result = INT_MAX;

        for (int d : divisors) {
            int score = 0;
            for (int num : nums) {
                if (num % d == 0) {
                    score++;
                }
            }
            if (score > maxScore) {
                maxScore = score;
                result = d;
            } else if (score == maxScore && d < result) {
                result = d;
            }
        }

        return result;
    }
};