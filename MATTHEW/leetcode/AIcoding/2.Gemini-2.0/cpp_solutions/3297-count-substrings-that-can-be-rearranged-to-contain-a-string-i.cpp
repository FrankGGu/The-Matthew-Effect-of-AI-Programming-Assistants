#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int countSubstrings(string s, string t) {
        int n = s.length();
        int m = t.length();
        int ans = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = s.substr(i, j - i + 1);
                if (canRearrange(sub, t)) {
                    ans++;
                }
            }
        }

        return ans;
    }

private:
    bool canRearrange(string s, string t) {
        int n = s.length();
        int m = t.length();
        if (n < m) return false;

        vector<int> sFreq(26, 0);
        vector<int> tFreq(26, 0);

        for (char c : t) {
            tFreq[c - 'a']++;
        }

        for (int i = 0; i < (1 << n); ++i) {
            string sub = "";
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    sub += s[j];
                }
            }
            if (sub.length() != m) continue;

            sFreq.assign(26, 0);
            for (char c : sub) {
                sFreq[c - 'a']++;
            }

            bool possible = true;
            for (int k = 0; k < 26; ++k) {
                if (sFreq[k] < tFreq[k]) {
                    possible = false;
                    break;
                }
            }
            if (possible) return true;
        }
        return false;
    }
};