#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string kthSmallestPath(vector<int>& destination, int k) {
        int vertical = destination[0];
        int horizontal = destination[1];
        int n = vertical + horizontal;
        string result = "";

        vector<vector<long long>> dp(n + 1, vector<long long>(n + 1, 0));
        for (int i = 0; i <= n; ++i) {
            dp[i][0] = 1;
        }
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
            }
        }

        int remaining_h = horizontal;
        int remaining_v = vertical;
        int remaining_steps = n;

        for (int i = 0; i < n; ++i) {
            if (remaining_h > 0) {
                long long ways_with_h = dp[remaining_h + remaining_v - 1][remaining_h - 1];
                if (k <= ways_with_h) {
                    result += 'H';
                    remaining_h--;
                } else {
                    result += 'V';
                    k -= ways_with_h;
                    remaining_v--;
                }
                remaining_steps--;
            } else {
                result += 'V';
            }
        }

        return result;
    }
};