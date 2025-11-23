#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumStrings(vector<string>& strs, string target) {
        unordered_map<char, int> charCount;
        for (char c : target) {
            charCount[c]++;
        }

        int n = strs.size();
        vector<vector<int>> dp(n + 1, vector<int>(26, 0));

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            for (char c : strs[i - 1]) {
                dp[i][c - 'a']++;
            }
        }

        int result = INT_MAX;
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < 26; ++j) {
                if (dp[i][j] >= charCount['a' + j]) {
                    result = min(result, i);
                    break;
                }
            }
        }

        return result == INT_MAX ? -1 : result;
    }
};