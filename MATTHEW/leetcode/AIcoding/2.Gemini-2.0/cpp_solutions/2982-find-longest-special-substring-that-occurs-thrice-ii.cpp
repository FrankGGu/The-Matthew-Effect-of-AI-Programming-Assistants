#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestSpecialSubstring(string s) {
        int n = s.length();
        int maxLen = 0;

        for (char c = 'a'; c <= 'z'; ++c) {
            int count = 0;
            int len = 0;
            for (int i = 0; i < n; ++i) {
                if (s[i] == c) {
                    int j = i;
                    while (j < n && s[j] == c) {
                        ++j;
                    }
                    int curLen = j - i;
                    if (curLen > len) {
                        len = curLen;
                    }
                    i = j - 1;
                }
            }

            int cnt = 0;
            int curLen = 0;
            for (int i = 0; i < n; ++i) {
                if (s[i] == c) {
                    int j = i;
                    while (j < n && s[j] == c) {
                        ++j;
                    }
                    int subLen = j - i;
                    if (subLen >= len) {
                        cnt++;
                    }
                    i = j - 1;
                }
            }
            if (cnt >= 3)
                maxLen = max(maxLen, len);
        }

        return maxLen;
    }
};