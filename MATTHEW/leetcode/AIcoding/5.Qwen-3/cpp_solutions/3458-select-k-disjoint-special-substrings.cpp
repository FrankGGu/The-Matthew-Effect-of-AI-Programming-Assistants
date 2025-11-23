#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int selectKDisjointSpecialSubstrings(string s, int k) {
        vector<vector<int>> dp(s.size(), vector<int>(s.size(), 0));
        for (int i = 0; i < s.size(); ++i) {
            dp[i][i] = 1;
        }
        for (int len = 2; len <= s.size(); ++len) {
            for (int i = 0; i <= s.size() - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j]) {
                    if (len == 2) {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] + 2;
                    }
                } else {
                    dp[i][j] = max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        vector<pair<int, int>> intervals;
        for (int i = 0; i < s.size(); ++i) {
            for (int j = i; j < s.size(); ++j) {
                if (dp[i][j] == j - i + 1) {
                    intervals.push_back({i, j});
                }
            }
        }

        sort(intervals.begin(), intervals.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.second < b.second;
        });

        vector<int> result;
        int count = 0;
        int lastEnd = -1;
        for (const auto& interval : intervals) {
            if (interval.first > lastEnd) {
                result.push_back(interval.first);
                result.push_back(interval.second);
                lastEnd = interval.second;
                count++;
                if (count == k) break;
            }
        }

        return result.size() / 2;
    }
};