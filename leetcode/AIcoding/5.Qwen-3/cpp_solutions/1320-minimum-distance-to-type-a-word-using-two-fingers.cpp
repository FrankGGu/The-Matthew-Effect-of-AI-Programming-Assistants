#include <iostream>
#include <vector>
#include <cmath>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumDistance(string word) {
        vector<vector<int>> dp(26, vector<int>(26, 0));
        for (int i = 0; i < 26; ++i) {
            for (int j = 0; j < 26; ++j) {
                dp[i][j] = abs(i / 6 - j / 6) + abs(i % 6 - j % 6);
            }
        }

        vector<vector<int>> prev(26, vector<int>(26, INT_MIN));
        for (int i = 0; i < 26; ++i) {
            prev[i][i] = 0;
        }

        for (int i = 1; i < word.size(); ++i) {
            vector<vector<int>> curr(26, vector<int>(26, INT_MIN));
            int c = word[i] - 'A';
            int p = word[i - 1] - 'A';
            for (int a = 0; a < 26; ++a) {
                for (int b = 0; b < 26; ++b) {
                    if (prev[a][b] == INT_MIN) continue;
                    if (a == p) {
                        curr[c][b] = max(curr[c][b], prev[a][b] + dp[a][c]);
                    }
                    if (b == p) {
                        curr[a][c] = max(curr[a][c], prev[a][b] + dp[b][c]);
                    }
                }
            }
            prev = curr;
        }

        int res = INT_MAX;
        for (int a = 0; a < 26; ++a) {
            for (int b = 0; b < 26; ++b) {
                if (prev[a][b] != INT_MIN) {
                    res = min(res, prev[a][b]);
                }
            }
        }
        return res;
    }
};