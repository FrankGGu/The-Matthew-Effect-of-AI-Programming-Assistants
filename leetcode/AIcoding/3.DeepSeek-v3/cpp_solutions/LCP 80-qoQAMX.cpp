#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int longestStrChain(vector<string>& words) {
        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.size() < b.size();
        });
        unordered_map<string, int> dp;
        int res = 0;
        for (const string& s : words) {
            int cur = 1;
            if (s.size() > 1) {
                for (int i = 0; i < s.size(); i++) {
                    string t = s.substr(0, i) + s.substr(i + 1);
                    if (dp.find(t) != dp.end()) {
                        cur = max(cur, dp[t] + 1);
                    }
                }
            }
            dp[s] = cur;
            res = max(res, cur);
        }
        return res;
    }
};