#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int minCostToMoveBook(vector<int>& books, int k) {
        int n = books.size();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + books[i - 1];
        }
        for (int i = 2; i <= n; ++i) {
            for (int j = i - 1; j >= 1 && j >= i - k; --j) {
                dp[i] = min(dp[i], dp[j] + dp[i] - dp[j]);
            }
        }
        return dp[n];
    }
};