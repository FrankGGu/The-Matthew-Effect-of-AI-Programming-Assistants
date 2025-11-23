#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long mostPoints(vector<vector<int>>& questions) {
        int n = questions.size();
        vector<long long> dp(n + 1, 0);

        for (int i = n - 1; i >= 0; --i) {
            int points = questions[i][0];
            int brainpower = questions[i][1];

            long long next_question = (i + brainpower + 1 < n) ? dp[i + brainpower + 1] : 0;
            dp[i] = max((long long)points + next_question, dp[i + 1]);
        }

        return dp[0];
    }
};