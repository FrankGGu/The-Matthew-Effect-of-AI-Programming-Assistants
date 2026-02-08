#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int booksSort(vector<int>& books) {
        int n = books.size();
        vector<int> dp(n, 0);
        dp[0] = 0;
        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i - 1] + (books[i] > books[i - 1] ? 0 : 1);
        }
        return dp[n - 1];
    }
};