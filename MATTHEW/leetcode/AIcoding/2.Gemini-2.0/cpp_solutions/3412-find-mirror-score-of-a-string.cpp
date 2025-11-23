#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mirrorScore(string s) {
        int n = s.length();
        int score = 0;
        for (int len = 1; len <= n / 2; ++len) {
            bool isMirror = true;
            for (int i = 0; i < len; ++i) {
                if (s[i] != s[2 * len - 1 - i]) {
                    isMirror = false;
                    break;
                }
            }
            if (isMirror) {
                score = max(score, len);
            }
        }
        return score;
    }
};