#include <iostream>
#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    int maxSatisfaction(vector<int>& satisfaction) {
        int n = satisfaction.size();
        vector<int> dp(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            dp[i] = max(dp[i + 1] + satisfaction[i], dp[i + 1]);
        }
        return dp[0];
    }
};