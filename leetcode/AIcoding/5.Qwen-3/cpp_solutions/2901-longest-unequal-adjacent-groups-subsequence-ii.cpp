#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> getSubsequence(const string& s, int n, const vector<int>& group) {
        vector<int> result;
        vector<int> dp(n, 1);
        vector<int> prev(n, -1);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (s[j] != s[i] && group[j] != group[i] && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }

        int maxIndex = 0;
        for (int i = 1; i < n; ++i) {
            if (dp[i] > dp[maxIndex]) {
                maxIndex = i;
            }
        }

        while (maxIndex != -1) {
            result.push_back(maxIndex);
            maxIndex = prev[maxIndex];
        }

        reverse(result.begin(), result.end());
        return result;
    }
};