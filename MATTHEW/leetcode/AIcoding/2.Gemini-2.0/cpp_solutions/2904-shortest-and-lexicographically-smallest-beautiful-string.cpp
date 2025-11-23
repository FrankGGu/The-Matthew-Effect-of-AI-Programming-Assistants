#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string shortestBeautifulSubstring(string s, int k) {
        int n = s.size();
        int minLen = n + 1;
        string ans = "";
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = i; j < n; ++j) {
                if (s[j] == '1') {
                    count++;
                }
                if (count == k) {
                    int len = j - i + 1;
                    string sub = s.substr(i, len);
                    if (len < minLen) {
                        minLen = len;
                        ans = sub;
                    } else if (len == minLen) {
                        if (ans == "" || sub < ans) {
                            ans = sub;
                        }
                    }
                    break;
                }
            }
        }
        return (minLen == n + 1) ? "" : ans;
    }
};