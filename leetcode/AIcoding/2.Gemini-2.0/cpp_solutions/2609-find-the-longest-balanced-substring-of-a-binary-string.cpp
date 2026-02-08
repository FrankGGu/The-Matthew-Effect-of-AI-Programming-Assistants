#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findTheLongestBalancedSubstring(string s) {
        int n = s.length();
        int maxLen = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                string sub = s.substr(i, j - i);
                int len = sub.length();
                if (len % 2 != 0) continue;

                int zeros = 0;
                int ones = 0;
                int k = 0;
                for (; k < len / 2; ++k) {
                    if (sub[k] == '0') {
                        zeros++;
                    } else {
                        break;
                    }
                }
                if(k != len/2) continue;

                for (; k < len; ++k) {
                    if (sub[k] == '1') {
                        ones++;
                    } else {
                        break;
                    }
                }
                if(k != len) continue;

                if (zeros == len / 2 && ones == len / 2) {
                    maxLen = max(maxLen, len);
                }
            }
        }
        return maxLen;
    }
};