#include <string>
#include <algorithm>

class Solution {
public:
    std::string getSmallestString(std::string s) {
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            int best_j = -1;
            for (int j = i + 1; j < n; ++j) {
                if ((s[i] - '0') % 2 == (s[j] - '0') % 2) {
                    if (s[j] < s[i]) {
                        if (best_j == -1 || s[j] <= s[best_j]) {
                            best_j = j;
                        }
                    }
                }
            }
            if (best_j != -1) {
                std::swap(s[i], s[best_j]);
                return s;
            }
        }
        return s;
    }
};