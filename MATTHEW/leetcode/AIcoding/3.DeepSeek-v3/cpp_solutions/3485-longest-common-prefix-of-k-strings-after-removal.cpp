#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestCommonPrefix(vector<string>& strs, int k) {
        if (strs.empty()) return "";
        int n = strs.size();
        string prefix = strs[0];
        for (int i = 1; i < n; ++i) {
            while (strs[i].find(prefix) != 0) {
                prefix = prefix.substr(0, prefix.size() - 1);
                if (prefix.empty()) return "";
            }
        }
        if (k == 0) return prefix;
        vector<int> cnt(26, 0);
        for (char c : prefix) {
            cnt[c - 'a']++;
        }
        string res;
        for (int i = 0; i < 26; ++i) {
            if (cnt[i] >= k) {
                res += string(cnt[i] - k + 1, 'a' + i);
            }
        }
        return res.empty() ? "" : res;
    }
};