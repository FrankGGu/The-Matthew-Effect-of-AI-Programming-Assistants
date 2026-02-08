#include <string>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    string smallestSubstring(string s) {
        int n = s.size();
        if (n == 0) return "";

        vector<int> lastPos(256, -1);
        int minLen = INT_MAX;
        int start = 0;

        for (int i = 0; i < n; ++i) {
            char c = s[i];
            if (lastPos[c] != -1) {
                int currentLen = i - lastPos[c] + 1;
                if (currentLen < minLen) {
                    minLen = currentLen;
                    start = lastPos[c];
                } else if (currentLen == minLen && lastPos[c] < start) {
                    start = lastPos[c];
                }
            }
            lastPos[c] = i;
        }

        return minLen == INT_MAX ? "" : s.substr(start, minLen);
    }
};