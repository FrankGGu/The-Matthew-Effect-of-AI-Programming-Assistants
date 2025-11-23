#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSemiRepetitiveSubstring(string s) {
        int n = s.length();
        int maxLength = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = s.substr(i, j - i + 1);
                int count = 0;
                for (int k = 0; k < sub.length() - 1; ++k) {
                    if (sub[k] == sub[k + 1]) {
                        count++;
                    }
                }
                if (count <= 1) {
                    maxLength = max(maxLength, (int)sub.length());
                }
            }
        }
        return maxLength;
    }
};