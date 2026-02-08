#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minHeightShelves(int width, vector<vector<int>>& books) {
        int n = books.size();
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            int currentWidth = 0;
            int maxHeight = 0;
            for (int j = i - 1; j >= 0 && currentWidth + books[j][0] <= width; --j) {
                currentWidth += books[j][0];
                maxHeight = max(maxHeight, books[j][1]);
                dp[i] = min(dp[i], dp[j] + maxHeight);
            }
        }

        return dp[n];
    }
};