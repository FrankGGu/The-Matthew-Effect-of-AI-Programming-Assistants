#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string minString(string s1, string s2) {
        vector<int> dp(s2.size() + 1, 0);
        for (int i = 0; i <= s2.size(); ++i) {
            dp[i] = i;
        }
        for (int i = 1; i <= s1.size(); ++i) {
            vector<int> new_dp(s2.size() + 1, 0);
            new_dp[0] = i;
            for (int j = 1; j <= s2.size(); ++j) {
                if (s1[i - 1] == s2[j - 1]) {
                    new_dp[j] = dp[j - 1];
                } else {
                    new_dp[j] = 1 + min(new_dp[j - 1], dp[j]);
                }
            }
            dp = new_dp;
        }
        return buildString(s1, s2, dp);
    }

private:
    string buildString(const string& s1, const string& s2, const vector<int>& dp) {
        string result;
        int i = s1.size(), j = s2.size();
        while (i > 0 || j > 0) {
            if (i > 0 && j > 0 && s1[i - 1] == s2[j - 1]) {
                result.push_back(s1[i - 1]);
                i--;
                j--;
            } else if (i > 0 && j > 0 && dp[i][j] == dp[i - 1][j - 1] + 1) {
                result.push_back(s1[i - 1]);
                i--;
            } else if (i > 0 && dp[i][j] == dp[i - 1][j] + 1) {
                result.push_back(s1[i - 1]);
                i--;
            } else {
                result.push_back(s2[j - 1]);
                j--;
            }
        }
        reverse(result.begin(), result.end());
        return result;
    }
};