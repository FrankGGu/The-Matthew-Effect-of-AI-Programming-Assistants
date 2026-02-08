#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestSubsequenceRepeatedK(string s, int k) {
        int n = s.size();
        string ans = "";
        string alph = "";
        vector<int> cnt(26, 0);
        for (char c : s) {
            cnt[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (cnt[i] >= k) {
                alph += (char)('a' + i);
            }
        }

        function<bool(string)> check = [&](string sub) {
            int sub_len = sub.size();
            int sub_idx = 0;
            int count = 0;
            for (int i = 0; i < n; i++) {
                if (s[i] == sub[sub_idx]) {
                    sub_idx++;
                    if (sub_idx == sub_len) {
                        count++;
                        sub_idx = 0;
                    }
                }
            }
            return count >= k;
        };

        function<void(string)> solve = [&](string curr) {
            if (check(curr)) {
                if (curr.size() > ans.size()) {
                    ans = curr;
                }
            } else {
                return;
            }

            for (char c : alph) {
                solve(curr + c);
            }
        };

        solve("");
        return ans;
    }
};