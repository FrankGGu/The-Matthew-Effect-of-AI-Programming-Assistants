#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestSpecialSubstring(string s) {
        int n = s.length();
        int maxLen = -1;

        for (int len = 1; len <= n / 3; ++len) {
            unordered_map<string, int> count;
            bool found = false;
            for (int i = 0; i <= n - len; ++i) {
                string sub = s.substr(i, len);
                bool special = true;
                for (int j = 1; j < len; ++j) {
                    if (sub[j] != sub[0]) {
                        special = false;
                        break;
                    }
                }
                if (special) {
                    count[sub]++;
                    if (count[sub] >= 3) {
                        found = true;
                        break;
                    }
                }
            }
            if (found) {
                maxLen = len;
            }
        }

        return maxLen;
    }
};