#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string minSubsequence(int n, int m, string s, string t) {
        vector<int> pos(26, -1);
        for (int i = 0; i < t.length(); ++i) {
            pos[t[i] - 'a'] = i;
        }

        vector<int> indices;
        for (int i = 0; i < s.length(); ++i) {
            if (pos[s[i] - 'a'] != -1) {
                indices.push_back(pos[s[i] - 'a']);
            }
        }

        int len = indices.size();
        if (len == 0) return "";

        vector<int> dp(len, 1);
        vector<int> prev(len, -1);

        for (int i = 0; i < len; ++i) {
            for (int j = 0; j < i; ++j) {
                if (indices[j] < indices[i] && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }

        int maxLen = *max_element(dp.begin(), dp.end());
        int idx = -1;
        for (int i = 0; i < len; ++i) {
            if (dp[i] == maxLen) {
                idx = i;
                break;
            }
        }

        string result;
        while (idx != -1) {
            result.push_back(t[indices[idx]]);
            idx = prev[idx];
        }

        reverse(result.begin(), result.end());
        return result;
    }
};