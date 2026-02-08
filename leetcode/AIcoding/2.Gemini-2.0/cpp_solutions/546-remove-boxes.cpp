#include <vector>

using namespace std;

class Solution {
public:
    int removeBoxes(vector<int>& boxes) {
        int n = boxes.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n, 0)));

        function<int(int, int, int)> solve = [&](int l, int r, int k) {
            if (l > r) {
                return 0;
            }
            if (dp[l][r][k] != 0) {
                return dp[l][r][k];
            }

            int originalL = l;
            int originalK = k;

            while (l < r && boxes[l] == boxes[l + 1]) {
                l++;
                k++;
            }

            int ans = (k + 1) * (k + 1) + solve(l + 1, r, 0);

            for (int m = l + 1; m <= r; m++) {
                if (boxes[m] == boxes[l]) {
                    ans = max(ans, solve(l + 1, m - 1, 0) + solve(m, r, k + 1));
                }
            }

            return dp[originalL][r][originalK] = ans;
        };

        return solve(0, n - 1, 0);
    }
};